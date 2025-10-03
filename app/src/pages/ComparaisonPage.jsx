// src/components/ComparisonPage.jsx
import { useState, useEffect } from 'react';
import { Loader2, ArrowRight, TrendingDown, TrendingUp, Download, FileText } from 'lucide-react';
import { DirectusDatas } from '../services/getDatas';
import { exportComparisonToCSV, exportComparisonToPDF } from '../utils/export';
import { PieChart, Pie, Cell, ResponsiveContainer, Tooltip } from 'recharts';
import Header from './HeaderPart';
import { calculateComparisonMetrics, SERVICE_CATEGORIES } from '../utils/serviceConfig';

const COLORS = ['#FB8C00', '#4CAF50', '#2196F3', '#F44336', '#9C27B0', '#FF9800'];

export default function ComparisonPage() {
  const [simulations, setSimulations] = useState([]);
  const [selectedSim1, setSelectedSim1] = useState(null);
  const [selectedSim2, setSelectedSim2] = useState(null);
  const [sim1Data, setSim1Data] = useState(null);
  const [sim2Data, setSim2Data] = useState(null);
  const [loading, setLoading] = useState(true);
  const [comparing, setComparing] = useState(false);
  const [services, setServices] = useState([]);
  const [regions, setRegions] = useState([]);
  const [instanceTypes, setInstanceTypes] = useState([]);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setLoading(true);
      const [simsData, servicesData, regionsData, instanceTypesData] = await Promise.all([
        DirectusDatas.getSimulations(),
        DirectusDatas.getServices(),
        DirectusDatas.getRegions(),
        DirectusDatas.getInstanceType()
      ]);
      
      setSimulations(simsData);
      setServices(servicesData);
      setRegions(regionsData);
      setInstanceTypes(instanceTypesData);
    } catch (error) {
      console.error('Erreur chargement:', error);
      alert('Erreur lors du chargement des simulations');
    } finally {
      setLoading(false);
    }
  };

  const loadSimulationDetails = async (simId) => {
    try {
      const resources = await DirectusDatas.getResourcesBySimulation(simId);
      return resources;
    } catch (error) {
      console.error('Erreur chargement ressources:', error);
      return [];
    }
  };

  const handleCompare = async () => {
    if (!selectedSim1 || !selectedSim2) {
      alert('Veuillez sélectionner deux simulations à comparer');
      return;
    }

    if (selectedSim1 === selectedSim2) {
      alert('Veuillez sélectionner deux simulations différentes');
      return;
    }

    try {
      setComparing(true);
      const [resources1, resources2] = await Promise.all([
        loadSimulationDetails(selectedSim1),
        loadSimulationDetails(selectedSim2)
      ]);

      setSim1Data({
        simulation: simulations.find(s => s.id === selectedSim1),
        resources: resources1
      });

      setSim2Data({
        simulation: simulations.find(s => s.id === selectedSim2),
        resources: resources2
      });
    } catch (error) {
      console.error('Erreur comparaison:', error);
      alert('Erreur lors de la comparaison');
    } finally {
      setComparing(false);
    }
  };

  const calculateTotalCost = (resources) => {
    return resources.reduce((sum, r) => sum + parseFloat(r.monthly_cost || 0), 0);
  };

  const getCostByService = (resources) => {
    const grouped = {};
    resources.forEach(r => {
      const service = services.find(s => s.id === r.service);
      const serviceName = service?.name || 'Autre';
      grouped[serviceName] = (grouped[serviceName] || 0) + parseFloat(r.monthly_cost || 0);
    });
    return Object.entries(grouped).map(([name, value]) => ({ name, value }));
  };

const getPerformanceMetrics = (resources) => {
  let totalVCPU = 0;
  let totalMemoryGB = 0;
  let totalInstancesWithType = 0; // Instances avec un type
  let totalResourcesCount = 0; // Toutes les ressources

  resources.forEach(r => {
    const quantity = r.configuration?.quantity || 1;
    totalResourcesCount += quantity;
    
    if (!r.instance_type) {
      // Ressource sans instance type (S3, Lambda, etc.)
      return;
    }

    const instanceType = instanceTypes.find(it => it.id === r.instance_type);
    
    if (instanceType) {
      totalVCPU += (instanceType.vcpu || 0) * quantity;
      
      const memoryMatch = instanceType.memory?.match(/(\d+)/);
      if (memoryMatch) {
        totalMemoryGB += parseInt(memoryMatch[1]) * quantity;
      }
      
      totalInstancesWithType += quantity;
    }
  });

  return { 
    totalVCPU, 
    totalMemoryGB, 
    totalInstances: totalInstancesWithType, // Seulement celles avec instance type
    totalResources: totalResourcesCount // Toutes les ressources
  };
};

  const enrichResource = (resource) => ({
    ...resource,
    service: services.find(s => s.id === resource.service),
    region: regions.find(r => r.id === resource.region),
    instance_type: instanceTypes.find(it => it.id === resource.instance_type)
  });

  const handleExportCSV = () => {
    if (!sim1Data || !sim2Data) return;
    
    const enriched1 = sim1Data.resources.map(enrichResource);
    const enriched2 = sim2Data.resources.map(enrichResource);
    
    exportComparisonToCSV(
      sim1Data.simulation,
      enriched1,
      sim2Data.simulation,
      enriched2
    );
  };

  const handleExportPDF = () => {
    if (!sim1Data || !sim2Data) return;
    
    const enriched1 = sim1Data.resources.map(enrichResource);
    const enriched2 = sim2Data.resources.map(enrichResource);
    
    exportComparisonToPDF(
      sim1Data.simulation,
      enriched1,
      sim2Data.simulation,
      enriched2
    );
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="text-center">
          <Loader2 className="animate-spin mx-auto mb-4 text-[#FB8C00]" size={48} />
          <p className="text-gray-600">Chargement des simulations...</p>
        </div>
      </div>
    );
  }

  return (
      <>  <Header />

    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-7xl mx-auto">
        <h1 className="text-3xl font-bold text-gray-800 mb-8">
          Comparaison de Simulations
        </h1>

        {/* Sélection des simulations */}
        <div className="bg-white rounded-xl shadow-md p-6 mb-6">
          <h2 className="text-xl font-semibold mb-4">Sélectionner les simulations à comparer</h2>
          
          <div className="grid md:grid-cols-2 gap-6">
            <div>
              <label className="block text-sm font-medium mb-2">Simulation 1</label>
              <select
                value={selectedSim1 || ''}
                onChange={(e) => setSelectedSim1(parseInt(e.target.value))}
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#FB8C00] outline-none"
              >
                <option value="">Sélectionner...</option>
                {simulations.map(sim => (
                  <option key={sim.id} value={sim.id}>
                    {sim.name} (${parseFloat(sim.monthly_coast || 0).toFixed(2)}/mois)
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium mb-2">Simulation 2</label>
              <select
                value={selectedSim2 || ''}
                onChange={(e) => setSelectedSim2(parseInt(e.target.value))}
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-[#FB8C00] outline-none"
              >
                <option value="">Sélectionner...</option>
                {simulations.map(sim => (
                  <option key={sim.id} value={sim.id}>
                    {sim.name} (${parseFloat(sim.monthly_coast || 0).toFixed(2)}/mois)
                  </option>
                ))}
              </select>
            </div>
          </div>

          <button
            onClick={handleCompare}
            disabled={!selectedSim1 || !selectedSim2 || comparing}
            className="mt-6 w-full px-6 py-3 bg-[#FB8C00] text-white rounded-lg hover:bg-[#F57C00] disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
          >
            {comparing ? (
              <>
                <Loader2 className="animate-spin" size={20} />
                Comparaison en cours...
              </>
            ) : (
              <>
                Comparer
                <ArrowRight size={20} />
              </>
            )}
          </button>
        </div>

        {/* Résultats de la comparaison */}
        {sim1Data && sim2Data && (() => {
          const metrics = calculateComparisonMetrics(sim1Data.resources, sim2Data.resources, services);

          return (
          <>
            {/* Métriques globales */}
            <div className="bg-gradient-to-r from-[#FB8C00]/10 to-blue-50 rounded-xl shadow-md p-6 mb-6 border-2 border-[#FB8C00]/20">
              <h2 className="text-xl font-semibold mb-4">💡 Analyse Comparative</h2>
              <div className="grid md:grid-cols-4 gap-4">
                <div className="bg-white rounded-lg p-4 text-center">
                  <p className="text-sm text-gray-600 mb-1">Simulation la moins chère</p>
                  <p className="text-lg font-bold text-[#FB8C00]">
                    {metrics.cheaperSimulation === 1 ? sim1Data.simulation.name : sim2Data.simulation.name}
                  </p>
                </div>
                <div className="bg-white rounded-lg p-4 text-center">
                  <p className="text-sm text-gray-600 mb-1">Différence en brut</p>
                  <p className={`text-2xl font-bold ${metrics.savings > 0 ? 'text-green-600' : metrics.savings < 0 ? 'text-red-600' : 'text-gray-600'}`}>
                    {metrics.savings > 0 ? '-' : metrics.savings < 0 ? '+' : ''}${Math.abs(metrics.savings).toFixed(2)}
                  </p>
                </div>
                <div className="bg-white rounded-lg p-4 text-center">
                  <p className="text-sm text-gray-600 mb-1">Différence en pourcentage</p>
                  <p className={`text-2xl font-bold ${metrics.savingsPercent > 0 ? 'text-green-600' : metrics.savingsPercent < 0 ? 'text-red-600' : 'text-gray-600'}`}>
                    {metrics.savingsPercent > 0 ? '-' : metrics.savingsPercent < 0 ? '+' : ''}{Math.abs(metrics.savingsPercent).toFixed(1)}%
                  </p>
                </div>
                <div className="bg-white rounded-lg p-4 text-center">
                  <p className="text-sm text-gray-600 mb-1">Catégories comparées</p>
                  <p className="text-2xl font-bold text-gray-900">
                    {new Set([...Object.keys(metrics.sim1Grouped), ...Object.keys(metrics.sim2Grouped)]).size}
                  </p>
                </div>
              </div>
            </div>

            {/* Résumé des coûts */}
            <div className="bg-white rounded-xl shadow-md p-6 mb-6">
              <div className="flex justify-between items-center mb-6">
                <h2 className="text-xl font-semibold">💰 Comparaison des Coûts Totaux</h2>
                <div className="flex gap-2">
                  <button
                    onClick={handleExportCSV}
                    className="px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 flex items-center gap-2"
                  >
                    <Download size={18} />
                    CSV
                  </button>
                  <button
                    onClick={handleExportPDF}
                    className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 flex items-center gap-2"
                  >
                    <FileText size={18} />
                    PDF
                  </button>
                </div>
              </div>

              <div className="grid md:grid-cols-3 gap-6">
                <div className="bg-blue-50 p-6 rounded-lg border-2 border-blue-200">
                  <div className="text-sm text-gray-600 mb-1">{sim1Data.simulation.name}</div>
                  <div className="text-3xl font-bold text-blue-600">
                    ${calculateTotalCost(sim1Data.resources).toFixed(2)}
                  </div>
                  <div className="text-xs text-gray-500 mt-1">par mois</div>
                </div>

                <div className="bg-gray-50 p-6 rounded-lg flex items-center justify-center">
                  {(() => {
                    const cost1 = calculateTotalCost(sim1Data.resources);
                    const cost2 = calculateTotalCost(sim2Data.resources);
                    const diff = cost2 - cost1;
                    const percent = cost1 > 0 ? ((diff / cost1) * 100).toFixed(1) : 0;
                    
                    return diff < 0 ? (
                      <div className="text-center">
                        <TrendingDown className="mx-auto mb-2 text-green-600" size={32} />
                        <div className="text-2xl font-bold text-green-600">
                          -${Math.abs(diff).toFixed(2)}
                        </div>
                        <div className="text-sm text-gray-600">
                          Économie de {Math.abs(percent)}%
                        </div>
                      </div>
                    ) : diff > 0 ? (
                      <div className="text-center">
                        <TrendingUp className="mx-auto mb-2 text-red-600" size={32} />
                        <div className="text-2xl font-bold text-red-600">
                          +${diff.toFixed(2)}
                        </div>
                        <div className="text-sm text-gray-600">
                          Augmentation de {percent}%
                        </div>
                      </div>
                    ) : (
                      <div className="text-center text-gray-600">
                        Coûts identiques
                      </div>
                    );
                  })()}
                </div>

                <div className="bg-orange-50 p-6 rounded-lg border-2 border-orange-200">
                  <div className="text-sm text-gray-600 mb-1">{sim2Data.simulation.name}</div>
                  <div className="text-3xl font-bold text-[#FB8C00]">
                    ${calculateTotalCost(sim2Data.resources).toFixed(2)}
                  </div>
                  <div className="text-xs text-gray-500 mt-1">par mois</div>
                </div>
              </div>
            </div>

            {/* Comparaison par catégorie de service */}
            <div className="bg-white rounded-xl shadow-md p-6 mb-6">
              <h2 className="text-xl font-semibold mb-4">📊 Coûts par Catégorie de Service</h2>

              {(() => {
                const metrics = calculateComparisonMetrics(sim1Data.resources, sim2Data.resources, services);
                const allCategories = new Set([
                  ...Object.keys(metrics.sim1Grouped),
                  ...Object.keys(metrics.sim2Grouped)
                ]);

                return (
                  <div className="space-y-4">
                    {Array.from(allCategories).map(category => {
                      const categoryConfig = SERVICE_CATEGORIES[category] || SERVICE_CATEGORIES['Compute'];
                      const sim1Category = metrics.sim1Grouped[category];
                      const sim2Category = metrics.sim2Grouped[category];
                      const sim1Cost = sim1Category?.totalCost || 0;
                      const sim2Cost = sim2Category?.totalCost || 0;
                      const diff = sim2Cost - sim1Cost;

                      return (
                        <div key={category} className={`border ${categoryConfig.borderColor} rounded-lg p-4`}>
                          <div className="flex items-center justify-between mb-3">
                            <h3 className={`font-bold ${categoryConfig.textColor} text-lg`}>
                              {categoryConfig.name}
                            </h3>
                            {diff !== 0 && (
                              <span className={`text-sm font-semibold ${diff < 0 ? 'text-green-600' : 'text-red-600'}`}>
                                {diff < 0 ? '↓' : '↑'} ${Math.abs(diff).toFixed(2)}
                              </span>
                            )}
                          </div>

                          <div className="grid md:grid-cols-2 gap-4">
                            {/* Simulation 1 */}
                            <div className={`${categoryConfig.bgColor} p-3 rounded-lg`}>
                              <p className="text-sm font-medium text-gray-700 mb-2">
                                {sim1Data.simulation.name}
                              </p>
                              <p className="text-2xl font-bold text-gray-900 mb-2">
                                ${sim1Cost.toFixed(2)} <span className="text-sm font-normal text-gray-600">/mois</span>
                              </p>
                              {sim1Category && (
                                <div className="text-xs text-gray-600 space-y-1">
                                  {sim1Category.resources.map((r, idx) => (
                                    <div key={idx} className="flex justify-between">
                                      <span>{r.serviceConfig.icon} {r.resource_name}</span>
                                      <span className="font-medium">${parseFloat(r.monthly_cost).toFixed(2)}</span>
                                    </div>
                                  ))}
                                </div>
                              )}
                              {!sim1Category && (
                                <p className="text-xs text-gray-500 italic">Aucune ressource</p>
                              )}
                            </div>

                            {/* Simulation 2 */}
                            <div className={`${categoryConfig.bgColor} p-3 rounded-lg`}>
                              <p className="text-sm font-medium text-gray-700 mb-2">
                                {sim2Data.simulation.name}
                              </p>
                              <p className="text-2xl font-bold text-gray-900 mb-2">
                                ${sim2Cost.toFixed(2)} <span className="text-sm font-normal text-gray-600">/mois</span>
                              </p>
                              {sim2Category && (
                                <div className="text-xs text-gray-600 space-y-1">
                                  {sim2Category.resources.map((r, idx) => (
                                    <div key={idx} className="flex justify-between">
                                      <span>{r.serviceConfig.icon} {r.resource_name}</span>
                                      <span className="font-medium">${parseFloat(r.monthly_cost).toFixed(2)}</span>
                                    </div>
                                  ))}
                                </div>
                              )}
                              {!sim2Category && (
                                <p className="text-xs text-gray-500 italic">Aucune ressource</p>
                              )}
                            </div>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                );
              })()}
            </div>

            {/* Comparaison détaillée ressource par ressource */}
            <div className="bg-white rounded-xl shadow-md p-6 mb-6">
              <h2 className="text-xl font-semibold mb-4">🔍 Comparaison Détaillée par Service</h2>

              {(() => {
                const metrics = calculateComparisonMetrics(sim1Data.resources, sim2Data.resources, services);
                const allCategories = new Set([
                  ...Object.keys(metrics.sim1Grouped),
                  ...Object.keys(metrics.sim2Grouped)
                ]);

                return Array.from(allCategories).map(category => {
                  const categoryConfig = SERVICE_CATEGORIES[category] || SERVICE_CATEGORIES['Compute'];
                  const sim1Resources = metrics.sim1Grouped[category]?.resources || [];
                  const sim2Resources = metrics.sim2Grouped[category]?.resources || [];

                  // Grouper par type de service
                  const serviceGroups = {};

                  [...sim1Resources, ...sim2Resources].forEach(r => {
                    const serviceCode = r.serviceConfig?.icon + ' ' + r.serviceName;
                    if (!serviceGroups[serviceCode]) {
                      serviceGroups[serviceCode] = { sim1: [], sim2: [] };
                    }
                  });

                  sim1Resources.forEach(r => {
                    const serviceCode = r.serviceConfig?.icon + ' ' + r.serviceName;
                    serviceGroups[serviceCode].sim1.push(r);
                  });

                  sim2Resources.forEach(r => {
                    const serviceCode = r.serviceConfig?.icon + ' ' + r.serviceName;
                    serviceGroups[serviceCode].sim2.push(r);
                  });

                  return (
                    <div key={category} className="mb-6">
                      <h3 className={`font-bold ${categoryConfig.textColor} text-lg mb-3`}>
                        {categoryConfig.name}
                      </h3>

                      {Object.entries(serviceGroups).map(([serviceName, data]) => (
                        <div key={serviceName} className={`border ${categoryConfig.borderColor} rounded-lg p-4 mb-3`}>
                          <h4 className="font-semibold text-gray-800 mb-3">{serviceName}</h4>

                          <div className="overflow-x-auto">
                            <table className="w-full text-sm">
                              <thead className={`${categoryConfig.bgColor}`}>
                                <tr>
                                  <th className="text-left p-2 font-medium">Nom</th>
                                  <th className="text-left p-2 font-medium">Type</th>
                                  <th className="text-center p-2 font-medium">vCPU</th>
                                  <th className="text-center p-2 font-medium">RAM</th>
                                  <th className="text-center p-2 font-medium">Quantité</th>
                                  <th className="text-right p-2 font-medium">Coût/mois</th>
                                  <th className="text-center p-2 font-medium">Simulation</th>
                                </tr>
                              </thead>
                              <tbody>
                                {data.sim1.map((resource, idx) => {
                                  const instanceType = instanceTypes.find(it => it.id === resource.instance_type);
                                  const config = typeof resource.configuration === 'string'
                                    ? JSON.parse(resource.configuration)
                                    : resource.configuration;

                                  return (
                                    <tr key={`sim1-${idx}`} className="border-t border-gray-200 hover:bg-blue-50">
                                      <td className="p-2">{resource.resource_name}</td>
                                      <td className="p-2 text-gray-600">{instanceType?.name || '-'}</td>
                                      <td className="p-2 text-center text-gray-600">{instanceType?.vcpu || '-'}</td>
                                      <td className="p-2 text-center text-gray-600">{instanceType?.memory || '-'}</td>
                                      <td className="p-2 text-center">{config?.quantity || 1}</td>
                                      <td className="p-2 text-right font-bold text-blue-600">
                                        ${parseFloat(resource.monthly_cost).toFixed(2)}
                                      </td>
                                      <td className="p-2 text-center">
                                        <span className="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs">
                                          {sim1Data.simulation.name}
                                        </span>
                                      </td>
                                    </tr>
                                  );
                                })}

                                {data.sim2.map((resource, idx) => {
                                  const instanceType = instanceTypes.find(it => it.id === resource.instance_type);
                                  const config = typeof resource.configuration === 'string'
                                    ? JSON.parse(resource.configuration)
                                    : resource.configuration;

                                  return (
                                    <tr key={`sim2-${idx}`} className="border-t border-gray-200 hover:bg-orange-50">
                                      <td className="p-2">{resource.resource_name}</td>
                                      <td className="p-2 text-gray-600">{instanceType?.name || '-'}</td>
                                      <td className="p-2 text-center text-gray-600">{instanceType?.vcpu || '-'}</td>
                                      <td className="p-2 text-center text-gray-600">{instanceType?.memory || '-'}</td>
                                      <td className="p-2 text-center">{config?.quantity || 1}</td>
                                      <td className="p-2 text-right font-bold text-[#FB8C00]">
                                        ${parseFloat(resource.monthly_cost).toFixed(2)}
                                      </td>
                                      <td className="p-2 text-center">
                                        <span className="px-2 py-1 bg-orange-100 text-orange-700 rounded text-xs">
                                          {sim2Data.simulation.name}
                                        </span>
                                      </td>
                                    </tr>
                                  );
                                })}

                                {/* Ligne de total pour ce service */}
                                <tr className={`${categoryConfig.bgColor} font-bold`}>
                                  <td colSpan="5" className="p-2 text-right">Total {serviceName}</td>
                                  <td className="p-2 text-right">
                                    <div className="space-y-1">
                                      <div className="text-blue-600">
                                        ${data.sim1.reduce((sum, r) => sum + parseFloat(r.monthly_cost), 0).toFixed(2)}
                                      </div>
                                      <div className="text-[#FB8C00]">
                                        ${data.sim2.reduce((sum, r) => sum + parseFloat(r.monthly_cost), 0).toFixed(2)}
                                      </div>
                                    </div>
                                  </td>
                                  <td className="p-2 text-center">
                                    {(() => {
                                      const total1 = data.sim1.reduce((sum, r) => sum + parseFloat(r.monthly_cost), 0);
                                      const total2 = data.sim2.reduce((sum, r) => sum + parseFloat(r.monthly_cost), 0);
                                      const diff = total2 - total1;

                                      return diff !== 0 ? (
                                        <span className={`text-xs font-semibold ${diff < 0 ? 'text-green-600' : 'text-red-600'}`}>
                                          {diff < 0 ? '↓' : '↑'} ${Math.abs(diff).toFixed(2)}
                                        </span>
                                      ) : (
                                        <span className="text-xs text-gray-500">=</span>
                                      );
                                    })()}
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </div>
                        </div>
                      ))}
                    </div>
                  );
                });
              })()}
            </div>

            {/* Statistiques clés */}
            <div className="bg-white rounded-xl shadow-md p-6 mb-6">
              <h2 className="text-xl font-semibold mb-4">📈 Statistiques Clés</h2>

              <div className="grid md:grid-cols-2 gap-6">
                {/* Simulation 1 */}
                <div className="border-2 border-blue-200 rounded-lg p-4">
                  <h3 className="font-bold text-blue-600 mb-3 text-lg">{sim1Data.simulation.name}</h3>

                  <div className="space-y-3">
                    {/* Compute */}
                    {(() => {
                      const computeResources = sim1Data.resources.filter(r => {
                        const service = services.find(s => s.id === r.service);
                        return ['EC2', 'ECS', 'EKS'].includes(service?.code);
                      });

                      if (computeResources.length > 0) {
                        let totalVCPU = 0;
                        let totalMemoryGB = 0;

                        computeResources.forEach(r => {
                          const instanceType = instanceTypes.find(it => it.id === r.instance_type);
                          const config = typeof r.configuration === 'string' ? JSON.parse(r.configuration) : r.configuration;
                          const quantity = config?.quantity || 1;

                          if (instanceType?.vcpu) {
                            totalVCPU += parseInt(instanceType.vcpu) * quantity;
                          }
                          if (instanceType?.memory) {
                            const memMatch = instanceType.memory.match(/(\d+)/);
                            if (memMatch) {
                              totalMemoryGB += parseInt(memMatch[1]) * quantity;
                            }
                          }
                        });

                        return (
                          <div className="bg-orange-50 rounded p-2">
                            <p className="text-xs text-gray-600 font-medium mb-1">🖥️ Compute (EC2, ECS, EKS)</p>
                            <div className="flex justify-between text-sm">
                              <span>{computeResources.length} ressource(s)</span>
                              <span className="font-bold">{totalVCPU} vCPU • {totalMemoryGB} GiB RAM</span>
                            </div>
                          </div>
                        );
                      }
                      return null;
                    })()}

                    {/* Database */}
                    {(() => {
                      const dbResources = sim1Data.resources.filter(r => {
                        const service = services.find(s => s.id === r.service);
                        return ['RDS', 'DynamoDB'].includes(service?.code);
                      });

                      if (dbResources.length > 0) {
                        return (
                          <div className="bg-purple-50 rounded p-2">
                            <p className="text-xs text-gray-600 font-medium mb-1">🗄️ Databases</p>
                            <div className="text-sm">
                              <span>{dbResources.length} base(s) de données</span>
                            </div>
                          </div>
                        );
                      }
                      return null;
                    })()}

                    {/* Storage */}
                    {(() => {
                      const storageResources = sim1Data.resources.filter(r => {
                        const service = services.find(s => s.id === r.service);
                        return ['S3'].includes(service?.code);
                      });

                      if (storageResources.length > 0) {
                        return (
                          <div className="bg-blue-50 rounded p-2">
                            <p className="text-xs text-gray-600 font-medium mb-1">🪣 Stockage</p>
                            <div className="text-sm">
                              <span>{storageResources.length} bucket(s) S3</span>
                            </div>
                          </div>
                        );
                      }
                      return null;
                    })()}

                    {/* Serverless */}
                    {(() => {
                      const serverlessResources = sim1Data.resources.filter(r => {
                        const service = services.find(s => s.id === r.service);
                        return ['Lambda'].includes(service?.code);
                      });

                      if (serverlessResources.length > 0) {
                        return (
                          <div className="bg-green-50 rounded p-2">
                            <p className="text-xs text-gray-600 font-medium mb-1">⚡ Serverless</p>
                            <div className="text-sm">
                              <span>{serverlessResources.length} fonction(s) Lambda</span>
                            </div>
                          </div>
                        );
                      }
                      return null;
                    })()}

                    <div className="border-t pt-2 mt-2">
                      <div className="flex justify-between text-sm font-bold">
                        <span>Total ressources</span>
                        <span className="text-blue-600">{sim1Data.resources.length}</span>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Simulation 2 */}
                <div className="border-2 border-orange-200 rounded-lg p-4">
                  <h3 className="font-bold text-[#FB8C00] mb-3 text-lg">{sim2Data.simulation.name}</h3>

                  <div className="space-y-3">
                    {/* Compute */}
                    {(() => {
                      const computeResources = sim2Data.resources.filter(r => {
                        const service = services.find(s => s.id === r.service);
                        return ['EC2', 'ECS', 'EKS'].includes(service?.code);
                      });

                      if (computeResources.length > 0) {
                        let totalVCPU = 0;
                        let totalMemoryGB = 0;

                        computeResources.forEach(r => {
                          const instanceType = instanceTypes.find(it => it.id === r.instance_type);
                          const config = typeof r.configuration === 'string' ? JSON.parse(r.configuration) : r.configuration;
                          const quantity = config?.quantity || 1;

                          if (instanceType?.vcpu) {
                            totalVCPU += parseInt(instanceType.vcpu) * quantity;
                          }
                          if (instanceType?.memory) {
                            const memMatch = instanceType.memory.match(/(\d+)/);
                            if (memMatch) {
                              totalMemoryGB += parseInt(memMatch[1]) * quantity;
                            }
                          }
                        });

                        return (
                          <div className="bg-orange-50 rounded p-2">
                            <p className="text-xs text-gray-600 font-medium mb-1">🖥️ Compute (EC2, ECS, EKS)</p>
                            <div className="flex justify-between text-sm">
                              <span>{computeResources.length} ressource(s)</span>
                              <span className="font-bold">{totalVCPU} vCPU • {totalMemoryGB} GiB RAM</span>
                            </div>
                          </div>
                        );
                      }
                      return null;
                    })()}

                    {/* Database */}
                    {(() => {
                      const dbResources = sim2Data.resources.filter(r => {
                        const service = services.find(s => s.id === r.service);
                        return ['RDS', 'DynamoDB'].includes(service?.code);
                      });

                      if (dbResources.length > 0) {
                        return (
                          <div className="bg-purple-50 rounded p-2">
                            <p className="text-xs text-gray-600 font-medium mb-1">🗄️ Databases</p>
                            <div className="text-sm">
                              <span>{dbResources.length} base(s) de données</span>
                            </div>
                          </div>
                        );
                      }
                      return null;
                    })()}

                    {/* Storage */}
                    {(() => {
                      const storageResources = sim2Data.resources.filter(r => {
                        const service = services.find(s => s.id === r.service);
                        return ['S3'].includes(service?.code);
                      });

                      if (storageResources.length > 0) {
                        return (
                          <div className="bg-blue-50 rounded p-2">
                            <p className="text-xs text-gray-600 font-medium mb-1">🪣 Stockage</p>
                            <div className="text-sm">
                              <span>{storageResources.length} bucket(s) S3</span>
                            </div>
                          </div>
                        );
                      }
                      return null;
                    })()}

                    {/* Serverless */}
                    {(() => {
                      const serverlessResources = sim2Data.resources.filter(r => {
                        const service = services.find(s => s.id === r.service);
                        return ['Lambda'].includes(service?.code);
                      });

                      if (serverlessResources.length > 0) {
                        return (
                          <div className="bg-green-50 rounded p-2">
                            <p className="text-xs text-gray-600 font-medium mb-1">⚡ Serverless</p>
                            <div className="text-sm">
                              <span>{serverlessResources.length} fonction(s) Lambda</span>
                            </div>
                          </div>
                        );
                      }
                      return null;
                    })()}

                    <div className="border-t pt-2 mt-2">
                      <div className="flex justify-between text-sm font-bold">
                        <span>Total ressources</span>
                        <span className="text-[#FB8C00]">{sim2Data.resources.length}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* Graphiques de répartition */}
            <div className="grid md:grid-cols-2 gap-6">
              <div className="bg-white rounded-xl shadow-md p-6">
                <h3 className="font-semibold mb-4">{sim1Data.simulation.name} - Répartition par service</h3>
                <ResponsiveContainer width="100%" height={300}>
                  <PieChart>
                    <Pie
                      data={getCostByService(sim1Data.resources)}
                      cx="50%"
                      cy="50%"
                      labelLine={false}
                      label={({ name, percent }) => `${name}: ${(percent * 100).toFixed(0)}%`}
                      outerRadius={80}
                      fill="#8884d8"
                      dataKey="value"
                    >
                      {getCostByService(sim1Data.resources).map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                      ))}
                    </Pie>
                    <Tooltip formatter={(value) => `$${parseFloat(value).toFixed(2)}`} />
                  </PieChart>
                </ResponsiveContainer>
              </div>

              <div className="bg-white rounded-xl shadow-md p-6">
                <h3 className="font-semibold mb-4">{sim2Data.simulation.name} - Répartition par service</h3>
                <ResponsiveContainer width="100%" height={300}>
                  <PieChart>
                    <Pie
                      data={getCostByService(sim2Data.resources)}
                      cx="50%"
                      cy="50%"
                      labelLine={false}
                      label={({ name, percent }) => `${name}: ${(percent * 100).toFixed(0)}%`}
                      outerRadius={80}
                      fill="#8884d8"
                      dataKey="value"
                    >
                      {getCostByService(sim2Data.resources).map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                      ))}
                    </Pie>
                    <Tooltip formatter={(value) => `$${parseFloat(value).toFixed(2)}`} />
                  </PieChart>
                </ResponsiveContainer>
              </div>
            </div>
          </>
          );
        })()}
      </div>
    </div>
    </>
  );
}