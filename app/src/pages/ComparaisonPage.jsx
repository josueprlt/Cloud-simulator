// src/components/ComparisonPage.jsx
import { useState, useEffect } from 'react';
import { Loader2, ArrowRight, TrendingDown, TrendingUp, Download, FileText } from 'lucide-react';
import { DirectusDatas } from '../services/getDatas';
import { exportComparisonToCSV, exportComparisonToPDF } from '../utils/export';
import { PieChart, Pie, Cell, ResponsiveContainer, Legend, Tooltip } from 'recharts';
import Header from './HeaderPart';

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
    let totalInstances = 0;

    resources.forEach(r => {
      const instanceType = instanceTypes.find(it => it.id === r.instance_type);
      if (instanceType) {
        const quantity = r.configuration?.quantity || 1;
        totalVCPU += (instanceType.vcpu || 0) * quantity;
        
        const memoryMatch = instanceType.memory?.match(/(\d+)/);
        if (memoryMatch) {
          totalMemoryGB += parseInt(memoryMatch[1]) * quantity;
        }
        totalInstances += quantity;
      }
    });

    return { totalVCPU, totalMemoryGB, totalInstances };
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
        {sim1Data && sim2Data && (
          <>
            {/* Résumé des coûts */}
            <div className="bg-white rounded-xl shadow-md p-6 mb-6">
              <div className="flex justify-between items-center mb-6">
                <h2 className="text-xl font-semibold">Comparaison des Coûts</h2>
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

            {/* Comparaison des performances */}
            <div className="bg-white rounded-xl shadow-md p-6 mb-6">
              <h2 className="text-xl font-semibold mb-4">Comparaison des Performances</h2>
              
              <div className="grid md:grid-cols-2 gap-6">
                <div>
                  <h3 className="font-medium text-gray-700 mb-3">{sim1Data.simulation.name}</h3>
                  {(() => {
                    const metrics = getPerformanceMetrics(sim1Data.resources);
                    return (
                      <div className="space-y-2">
                        <div className="flex justify-between">
                          <span className="text-gray-600">Total vCPUs:</span>
                          <span className="font-semibold">{metrics.totalVCPU}</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-gray-600">Total RAM:</span>
                          <span className="font-semibold">{metrics.totalMemoryGB} GiB</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-gray-600">Instances:</span>
                          <span className="font-semibold">{metrics.totalInstances}</span>
                        </div>
                      </div>
                    );
                  })()}
                </div>

                <div>
                  <h3 className="font-medium text-gray-700 mb-3">{sim2Data.simulation.name}</h3>
                  {(() => {
                    const metrics = getPerformanceMetrics(sim2Data.resources);
                    return (
                      <div className="space-y-2">
                        <div className="flex justify-between">
                          <span className="text-gray-600">Total vCPUs:</span>
                          <span className="font-semibold">{metrics.totalVCPU}</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-gray-600">Total RAM:</span>
                          <span className="font-semibold">{metrics.totalMemoryGB} GiB</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-gray-600">Instances:</span>
                          <span className="font-semibold">{metrics.totalInstances}</span>
                        </div>
                      </div>
                    );
                  })()}
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
        )}
      </div>
    </div>
    </>
  );
}