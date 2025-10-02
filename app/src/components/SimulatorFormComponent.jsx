import { useState, useEffect } from 'react';
import { Plus, Trash2, Save, TrendingDown, Loader2, Download, FileText } from 'lucide-react';
import { exportSimulationToCSV, exportSimulationToPDF } from '../utils/export';
import { DirectusDatas } from '../services/getDatas';

const TEMPLATES = {
  blank: {
    name: "Partir de zéro",
    description: "Construisez votre architecture depuis le début",
    resources: []
  },
  webapp: {
    name: "Application Web classique",
    description: "3x EC2 + 1x RDS + S3",
    resources: [
      { service: "EC2", instance_type: "t3.medium", configuration: { quantity: 3, hours_per_month: 730, os: "Linux" }, region: "us-east-1" },
      { service: "RDS", instance_type: "db.t3.large", configuration: { quantity: 1, hours_per_month: 730, os: "Linux" }, region: "us-east-1" },
      { service: "S3", configuration: { quantity: 1, hours_per_month: 730, storage_gb: 500, os: "Linux" }, region: "us-east-1" }
    ]
  },
  kubernetes: {
    name: "Cluster Kubernetes",
    description: "EKS + EC2 workers + RDS",
    resources: [
      { service: "EKS", configuration: { quantity: 1, hours_per_month: 730, os: "Linux" }, region: "us-east-1" },
      { service: "EC2", instance_type: "t3.large", configuration: { quantity: 5, hours_per_month: 730, os: "Linux" }, region: "us-east-1" },
      { service: "RDS", instance_type: "db.r5.xlarge", configuration: { quantity: 1, hours_per_month: 730, os: "Linux" }, region: "us-east-1" }
    ]
  }
};

export default function SimulationWizard() {
  const [step, setStep] = useState(1);
  const [selectedTemplate, setSelectedTemplate] = useState(null);
  const [simulation, setSimulation] = useState({
    name: "",
    description: "",
    scenario_type: "current"
  });
  const [resources, setResources] = useState([]);
  const [editingResource, setEditingResource] = useState(null);
  
  const [services, setServices] = useState([]);
  const [regions, setRegions] = useState([]);
  const [instanceTypes, setInstanceTypes] = useState([]);
  const [prices, setPrices] = useState([]);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    loadReferenceData();
  }, []);

  const loadReferenceData = async () => {
    try {
      setLoading(true);
      const [servicesData, regionsData, instanceTypesData, pricesData] = await Promise.all([
        DirectusDatas.getServices(),
        DirectusDatas.getRegions(),
        DirectusDatas.getInstanceType(),
        DirectusDatas.getPrices()
      ]);
      
      setServices(servicesData);
      setRegions(regionsData);
      setInstanceTypes(instanceTypesData);
      setPrices(pricesData);
    } catch (error) {
      console.error('Erreur chargement données:', error);
      alert('Erreur lors du chargement des données. Vérifiez votre connexion à Directus.');
    } finally {
      setLoading(false);
    }
  };

  const calculateMonthlyCost = (resource) => {
    const price = prices.find(p => 
      p.service === resource.service &&
      p.region === resource.region &&
      p.instance_type === resource.instance_type
    );
    
    const unitPrice = price ? parseFloat(price.price_hourly) : 0.05;
    const quantity = resource.configuration?.quantity || 1;
    const hours = resource.configuration?.hours_per_month || 730;
    
    return (unitPrice * quantity * hours).toFixed(2);
  };

  const selectTemplate = (templateKey) => {
    const template = TEMPLATES[templateKey];
    setSelectedTemplate(templateKey);
    
    setResources(template.resources.map((r, i) => {
      const service = services.find(s => s.code === r.service);
      const region = regions.find(reg => reg.code === r.region);
      const instanceType = r.instance_type ? instanceTypes.find(it => it.name === r.instance_type) : null;
      
      const resourceObj = {
        id: `temp-${i}`,
        resource_name: `${r.service} ${i + 1}`,
        service: service?.id || null,
        region: region?.id || null,
        instance_type: instanceType?.id || null,
        configuration: r.configuration || {
          quantity: 1,
          hours_per_month: 730,
          os: "Linux"
        },
        unit_price: 0.05
      };
      
      return {
        ...resourceObj,
        monthly_cost: calculateMonthlyCost(resourceObj)
      };
    }));
    setStep(2);
  };

  const addResource = () => {
    const defaultService = services[0];
    const defaultRegion = regions[0];
    const defaultInstanceType = instanceTypes[0]; // Prend le premier disponible
    
    setEditingResource({
      id: `temp-${Date.now()}`,
      resource_name: "",
      service: defaultService?.id || null,
      region: defaultRegion?.id || null,
      instance_type: defaultInstanceType?.id || null,
      configuration: {
        quantity: 1,
        hours_per_month: 730,
        os: "Linux"
      },
      unit_price: 0.05,
      monthly_cost: "36.50"
    });
  };

  const saveResource = () => {
    if (!editingResource) return;

    const updatedResource = {
      ...editingResource,
      monthly_cost: calculateMonthlyCost(editingResource)
    };

    if (updatedResource.id.startsWith('temp-') && !resources.find(r => r.id === updatedResource.id)) {
      setResources([...resources, updatedResource]);
    } else {
      setResources(resources.map(r => r.id === updatedResource.id ? updatedResource : r));
    }
    setEditingResource(null);
  };

  const deleteResource = (id) => {
    setResources(resources.filter(r => r.id !== id));
  };

  const totalCost = resources.reduce((sum, r) => sum + parseFloat(r.monthly_cost || "0"), 0);

  const saveSimulation = async () => {
    if (!simulation.name) {
      alert('Veuillez donner un nom à la simulation');
      return;
    }

    if (resources.length === 0) {
      alert('Veuillez ajouter au moins une ressource');
      return;
    }

    try {
      setSaving(true);
      
      const simulationPayload = {
        name: simulation.name,
        description: simulation.description,
        status: 'draft',
        scenario_type: simulation.scenario_type,
        monthly_coast: totalCost.toFixed(2),
        created_at: new Date().toISOString()
      };
      
      const createdSimulation = await DirectusDatas.createSimulation(simulationPayload);

      for (const resource of resources) {
        await DirectusDatas.createResources({
          simulations_id: createdSimulation.id,
          resource_name: resource.resource_name,
          service: resource.service,
          region: resource.region,
          instance_types: resource.instance_type,
          configuration: resource.configuration,
          unit_price: resource.unit_price,
          monthly_cost: resource.monthly_cost
        });
      }

      alert(`✅ Simulation "${simulation.name}" sauvegardée avec succès !\n\nCoût total: $${totalCost.toFixed(2)}/mois`);
      
      setSimulation({ name: "", description: "", scenario_type: "current" });
      setResources([]);
      setStep(1);
      
    } catch (error) {
      console.error('Erreur sauvegarde:', error);
      alert(`❌ Erreur lors de la sauvegarde: ${error.message}`);
    } finally {
      setSaving(false);
    }
  };

  const createOptimizedVariant = () => {
    alert("🤖 Analyse en cours...\n\nRecommandations:\n- Passer en Reserved Instances (-40%)\n- Utiliser Spot Instances pour dev (-70%)\n- Right-sizing: t3.large → t3.medium (-50%)");
  };

  const updateResourceField = (field, value) => {
    if (!editingResource) return;
    setEditingResource({ ...editingResource, [field]: value });
  };

  const updateConfigField = (field, value) => {
    if (!editingResource) return;
    setEditingResource({
      ...editingResource,
      configuration: { ...editingResource.configuration, [field]: value }
    });
  };

  useEffect(() => {
    if (editingResource) {
      const newCost = calculateMonthlyCost(editingResource);
      if (newCost !== editingResource.monthly_cost) {
        setEditingResource(prev => ({
          ...prev,
          monthly_cost: newCost
        }));
      }
    }
  }, [editingResource?.configuration?.quantity, editingResource?.configuration?.hours_per_month, editingResource?.service, editingResource?.region, editingResource?.instance_type]);

  const handleExportCSV = () => {
    if (resources.length === 0) {
      alert('Aucune ressource à exporter');
      return;
    }
    
    if (!simulation.name) {
      alert('Veuillez donner un nom à la simulation avant d\'exporter');
      return;
    }
    
    const enrichedResources = resources.map(r => ({
      ...r,
      service: services.find(s => s.id === r.service) || r.service,
      region: regions.find(reg => reg.id === r.region) || r.region,
      instance_type: instanceTypes.find(it => it.id === r.instance_type) || r.instance_type
    }));
    
    exportSimulationToCSV(simulation, enrichedResources);
    alert('✅ Export CSV téléchargé !');
  };

  const handleExportPDF = () => {
    if (resources.length === 0) {
      alert('Aucune ressource à exporter');
      return;
    }
    
    if (!simulation.name) {
      alert('Veuillez donner un nom à la simulation avant d\'exporter');
      return;
    }
    
    const enrichedResources = resources.map(r => ({
      ...r,
      service: services.find(s => s.id === r.service) || r.service,
      region: regions.find(reg => reg.id === r.region) || r.region,
      instance_type: instanceTypes.find(it => it.id === r.instance_type) || r.instance_type
    }));
    
    exportSimulationToPDF(simulation, enrichedResources);
    alert('✅ Export PDF téléchargé !');
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="animate-spin mx-auto mb-4 text-[#FB8C00]" size={48} />
          <p className="text-gray-600">Chargement des données...</p>
        </div>
      </div>
    );
  }

  if (step === 1) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-[#FB8C00]/20 to-[#FB8C00]/0 p-8">
        <div className="max-w-5xl mx-auto">
          <div className="text-center mb-12">
            <h1 className="text-4xl font-bold text-gray-800 mb-4">
              Simulateur de Coûts AWS
            </h1>
            <p className="text-lg text-gray-600">
              Estimez et optimisez vos dépenses cloud avant le déploiement
            </p>
          </div>

          <div className="mb-8">
            <h2 className="text-2xl font-semibold mb-6 text-gray-800">
              Choisissez un point de départ
            </h2>
            <div className="grid md:grid-cols-3 gap-6">
              {Object.entries(TEMPLATES).map(([key, template]) => (
                <button
                  key={key}
                  onClick={() => selectTemplate(key)}
                  className="bg-white p-6 rounded-xl shadow-lg hover:shadow-xl transition-all border-2 border-transparent hover:border-[#FB8C00] text-left"
                >
                  <h3 className="text-xl font-semibold mb-2 text-gray-800">
                    {template.name}
                  </h3>
                  <p className="text-gray-600 text-sm">
                    {template.description}
                  </p>
                  <div className="mt-4 text-[#FB8C00] font-medium">
                    {template.resources.length} ressources →
                  </div>
                </button>
              ))}
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (step === 2) {
    return (
      <div className="min-h-screen bg-gray-50 p-8">
        <div className="max-w-7xl mx-auto">
          <div className="bg-white rounded-xl shadow-md p-6 mb-6">
            <div className="flex justify-between items-start mb-4">
              <div className="flex-1">
                <input
                  type="text"
                  placeholder="Nom de la simulation"
                  value={simulation.name}
                  onChange={(e) => setSimulation({...simulation, name: e.target.value})}
                  className="text-2xl font-bold border-b-2 border-transparent hover:border-gray-300 focus:border-[#FB8C00] outline-none px-2 w-full"
                />
                <input
                  type="text"
                  placeholder="Description (optionnel)"
                  value={simulation.description}
                  onChange={(e) => setSimulation({...simulation, description: e.target.value})}
                  className="text-gray-600 mt-2 border-b border-transparent hover:border-gray-300 focus:border-gray-400 outline-none px-2 w-full"
                />
              </div>
              <div className="text-right ml-6">
                <div className="text-sm text-gray-500">Coût mensuel estimé</div>
                <div className="text-3xl font-bold text-[#FB8C00]">
                  ${totalCost.toFixed(2)}
                </div>
              </div>
            </div>
            
            <div className="flex gap-3 flex-wrap">
              <button
                onClick={() => setStep(1)}
                className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50"
              >
                ← Retour
              </button>
              <button
                onClick={createOptimizedVariant}
                className="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 flex items-center gap-2"
              >
                <TrendingDown size={18} />
                Optimiser
              </button>
              
              <div className="flex gap-2 ml-auto">
                <button
                  onClick={handleExportCSV}
                  disabled={resources.length === 0}
                  className="px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 flex items-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
                  title="Exporter en CSV"
                >
                  <Download size={18} />
                  CSV
                </button>
                <button
                  onClick={handleExportPDF}
                  disabled={resources.length === 0}
                  className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 flex items-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
                  title="Exporter en PDF"
                >
                  <FileText size={18} />
                  PDF
                </button>
                <button
                  onClick={saveSimulation}
                  disabled={saving || resources.length === 0 || !simulation.name}
                  className="px-4 py-2 bg-[#FB8C00] text-white rounded-lg hover:bg-[#F57C00] flex items-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {saving ? <Loader2 className="animate-spin" size={18} /> : <Save size={18} />}
                  {saving ? 'Sauvegarde...' : 'Sauvegarder'}
                </button>
              </div>
            </div>
          </div>

          <div className="bg-white rounded-xl shadow-md p-6 mb-6">
            <div className="flex justify-between items-center mb-4">
              <h2 className="text-xl font-semibold">Ressources ({resources.length})</h2>
              <button
                onClick={addResource}
                className="px-4 py-2 bg-[#FB8C00] text-white rounded-lg hover:bg-[#F57C00] flex items-center gap-2"
              >
                <Plus size={18} />
                Ajouter une ressource
              </button>
            </div>

            <div className="space-y-3">
              {resources.map((resource) => {
                const service = services.find(s => s.id === resource.service);
                const region = regions.find(r => r.id === resource.region);
                const instanceType = instanceTypes.find(it => it.id === resource.instance_type);
                
                return (
                  <div key={resource.id} className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow">
                    <div className="flex justify-between items-start">
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-2">
                          <span className="px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-sm font-medium">
                            {service?.name || service?.code || 'N/A'}
                          </span>
                          <h3 className="font-semibold text-gray-800">
                            {resource.resource_name || `${service?.name || 'Resource'}`}
                          </h3>
                        </div>
                        <div className="text-sm text-gray-600 space-y-1">
                          <div>
                            <span className="font-medium">Région:</span> {region?.name || 'N/A'}
                          </div>
                          {instanceType && (
                            <div>
                              <span className="font-medium">Type:</span> {instanceType.name}
                            </div>
                          )}
                          <div>
                            <span className="font-medium">Quantité:</span> {resource.configuration.quantity} × {resource.configuration.hours_per_month}h/mois
                          </div>
                        </div>
                      </div>
                      <div className="text-right">
                        <div className="text-2xl font-bold text-gray-800">
                          ${resource.monthly_cost}
                        </div>
                        <div className="text-xs text-gray-500">par mois</div>
                        <div className="flex gap-2 mt-2">
                          <button
                            onClick={() => setEditingResource(resource)}
                            className="px-3 py-1 text-sm border border-gray-300 rounded hover:bg-gray-50"
                          >
                            Modifier
                          </button>
                          <button
                            onClick={() => deleteResource(resource.id)}
                            className="px-3 py-1 text-sm text-red-600 border border-red-300 rounded hover:bg-red-50"
                          >
                            <Trash2 size={14} />
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                );
              })}

              {resources.length === 0 && (
                <div className="text-center py-12 text-gray-400">
                  Aucune ressource. Cliquez sur "Ajouter une ressource" pour commencer.
                </div>
              )}
            </div>
          </div>

          {editingResource && (
            <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
              <div className="bg-white rounded-xl p-6 max-w-2xl w-full max-h-[90vh] overflow-y-auto">
                <h3 className="text-2xl font-bold mb-6">
                  {editingResource.id.startsWith('temp-') && !resources.find(r => r.id === editingResource.id) 
                    ? "Ajouter une ressource" 
                    : "Modifier la ressource"}
                </h3>

                <div className="space-y-4">
                  <div>
                    <label className="block text-sm font-medium mb-2">Nom de la ressource</label>
                    <input
                      type="text"
                      value={editingResource.resource_name}
                      onChange={(e) => updateResourceField('resource_name', e.target.value)}
                      placeholder="Ex: Production Web Servers"
                      className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#FB8C00] outline-none"
                    />
                  </div>

                  <div className="grid md:grid-cols-2 gap-4">
                    <div>
                      <label className="block text-sm font-medium mb-2">Service</label>
                      <select
                        value={editingResource.service || ''}
                        onChange={(e) => updateResourceField('service', parseInt(e.target.value))}
                        className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#FB8C00] outline-none"
                      >
                        <option value="">Sélectionner un service</option>
                        {services.map(s => (
                          <option key={s.id} value={s.id}>{s.name}</option>
                        ))}
                      </select>
                    </div>

                    <div>
                      <label className="block text-sm font-medium mb-2">Région</label>
                      <select
                        value={editingResource.region || ''}
                        onChange={(e) => updateResourceField('region', parseInt(e.target.value))}
                        className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#FB8C00] outline-none"
                      >
                        <option value="">Sélectionner une région</option>
                        {regions.map(r => (
                          <option key={r.id} value={r.id}>
                            {r.name}
                          </option>
                        ))}
                      </select>
                    </div>
                  </div>

                  {/* DROPDOWN INSTANCE TYPE - AFFICHE TOUS LES TYPES */}
                  {instanceTypes.length > 0 && (
                    <div>
                      <label className="block text-sm font-medium mb-2">Type d'instance</label>
                      <select
                        value={editingResource.instance_type || ''}
                        onChange={(e) => updateResourceField('instance_type', parseInt(e.target.value))}
                        className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#FB8C00] outline-none"
                      >
                        <option value="">Sélectionner un type</option>
                        {instanceTypes.map(type => (
                          <option key={type.id} value={type.id}>
                            {type.name} ({type.vcpu} vCPU, {type.memory})
                          </option>
                        ))}
                      </select>
                    </div>
                  )}

                  <div className="grid md:grid-cols-2 gap-4">
                    <div>
                      <label className="block text-sm font-medium mb-2">Quantité</label>
                      <input
                        type="number"
                        min="1"
                        value={editingResource.configuration.quantity}
                        onChange={(e) => updateConfigField('quantity', parseInt(e.target.value) || 1)}
                        className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#FB8C00] outline-none"
                      />
                    </div>

                    <div>
                      <label className="block text-sm font-medium mb-2">Heures/mois</label>
                      <input
                        type="number"
                        min="1"
                        max="730"
                        value={editingResource.configuration.hours_per_month}
                        onChange={(e) => updateConfigField('hours_per_month', parseInt(e.target.value) || 730)}
                        className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#FB8C00] outline-none"
                      />
                    </div>
                  </div>

                  <div className="bg-orange-50 p-4 rounded-lg border border-orange-200">
                    <div className="text-sm text-gray-600 mb-1">Coût mensuel estimé</div>
                    <div className="text-3xl font-bold text-[#FB8C00]">
                      ${editingResource.monthly_cost}
                    </div>
                    <div className="text-xs text-gray-500 mt-1">
                      {editingResource.configuration.quantity} × {editingResource.configuration.hours_per_month}h
                    </div>
                  </div>
                </div>

                <div className="flex gap-3 mt-6">
                  <button
                    onClick={() => setEditingResource(null)}
                    className="flex-1 px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50"
                  >
                    Annuler
                  </button>
                  <button
                    onClick={saveResource}
                    className="flex-1 px-4 py-2 bg-[#FB8C00] text-white rounded-lg hover:bg-[#F57C00]"
                  >
                    Enregistrer
                  </button>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    );
  }

  return null;
}