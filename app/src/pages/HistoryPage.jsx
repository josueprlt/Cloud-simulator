import {useEffect, useState} from 'react';
import {DirectusDatas} from '../services/getDatas.js';
import Header from './HeaderPart.jsx';
import ModalComponent from '../components/ModalComponent.jsx';
import { Server, Globe, Cpu, HardDrive } from 'lucide-react';

export default function HistoryPage() {
    const [open, setOpen] = useState(false);
    const [selectedSimulation, setSelectedSimulation] = useState(null);
    const [selectedResources, setSelectedResources] = useState([]);

    const [simulations, setSimulations] = useState([]);
    const [services, setServices] = useState([]);
    const [regions, setRegions] = useState([]);
    const [instanceTypes, setInstanceTypes] = useState([]);
    const [loading, setLoading] = useState(true);
    const [loadingResources, setLoadingResources] = useState(false);
    const [error, setError] = useState(null);

    useEffect(() => {
        document.title = 'Historique | CloudSim';

        async function fetchData() {
            try {
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
            } catch (err) {
                setError('Erreur lors du chargement des simulations.');
            } finally {
                setLoading(false);
            }
        }

        fetchData();
    }, []);

    const handleSimulationClick = async (simulation) => {
        setSelectedSimulation(simulation);
        setOpen(true);
        setLoadingResources(true);

        try {
            const resources = await DirectusDatas.getResourcesBySimulation(simulation.id);
            setSelectedResources(resources);
        } catch (err) {
            console.error('Erreur lors du chargement des ressources:', err);
            setSelectedResources([]);
        } finally {
            setLoadingResources(false);
        }
    };

    return (
        <>
            <Header/>

            <main className="min-h-screen bg-gradient-to-br from-[#FB8C00]/20 to-[#FB8C00]/0 p-8">
                <div className="max-w-7xl mx-auto space-y-8">
                    <h1 className="text-4xl font-extrabold text-[#FB8C00] border-b pb-2">
                        Historique des simulations
                    </h1>

                    <ModalComponent isOpen={open} onClose={() => setOpen(false)}>
                        {selectedSimulation && (
                            <div className="space-y-6">
                                <div className="flex justify-between items-start border-b border-gray-200 pb-4">
                                    <div>
                                        <h2 className="text-2xl font-bold text-gray-900 mb-2">
                                            {selectedSimulation.name}
                                        </h2>
                                        {selectedSimulation.description && (
                                            <p className="text-gray-600">{selectedSimulation.description}</p>
                                        )}
                                    </div>
                          
                                </div>

                                <div className="bg-[#FB8C00]/10 p-4 rounded-lg border border-[#FB8C00]/20">
                                    <p className="text-sm text-gray-600 mb-1">Coût mensuel estimé</p>
                                    <p className="text-3xl font-bold text-[#FB8C00]">
                                        {Number.parseFloat(selectedSimulation.monthly_coast).toFixed(2)} USD
                                    </p>
                                </div>

                                <div className="grid grid-cols-2 gap-4">
                                    <div className="bg-gray-50 p-3 rounded-lg">
                                        <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">ID</p>
                                        <p className="text-sm font-semibold text-gray-900">{selectedSimulation.id}</p>
                                    </div>

                                    {selectedSimulation.scenario_type && (
                                        <div className="bg-gray-50 p-3 rounded-lg">
                                            <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">Type de
                                                scénario</p>
                                            <p className="text-sm font-semibold text-gray-900">{selectedSimulation.scenario_type}</p>
                                        </div>
                                    )}

                                    <div className="bg-gray-50 p-3 rounded-lg">
                                        <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">Date de
                                            création</p>
                                        <p className="text-sm font-semibold text-gray-900">
                                            {new Date(selectedSimulation.created_at).toLocaleDateString('fr-FR')}
                                        </p>
                                    </div>

                                    {selectedSimulation.updated_at && (
                                        <div className="bg-gray-50 p-3 rounded-lg">
                                            <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">Dernière
                                                modification</p>
                                            <p className="text-sm font-semibold text-gray-900">
                                                {new Date(selectedSimulation.updated_at).toLocaleDateString('fr-FR')}
                                            </p>
                                        </div>
                                    )}
                                </div>

                                {/* Ressources détaillées */}
                                <div className="bg-gray-50 p-4 rounded-lg">
                                    <p className="text-xs text-gray-500 uppercase tracking-wide mb-3">
                                        Ressources utilisées ({selectedResources.length})
                                    </p>

                                    {loadingResources ? (
                                        <div className="text-center py-6">
                                            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-[#FB8C00] mx-auto"></div>
                                            <p className="text-sm text-gray-500 mt-2">Chargement des ressources...</p>
                                        </div>
                                    ) : selectedResources.length > 0 ? (
                                        <div className="space-y-2">
                                            {selectedResources.map((resource, index) => {
                                                const service = services.find(s => s.id === resource.service);
                                                const region = regions.find(r => r.id === resource.region);
                                                const instanceType = instanceTypes.find(it => it.id === resource.instance_types);
                                                const config = typeof resource.configuration === 'string'
                                                    ? JSON.parse(resource.configuration)
                                                    : resource.configuration;

                                                return (
                                                    <div key={index} className="bg-white border border-gray-200 rounded-lg p-3 hover:border-[#FB8C00]/50 transition-all">
                                                        <div className="flex items-center justify-between gap-3">
                                                            {/* Left: Icon + Name + Service */}
                                                            <div className="flex items-center gap-2 min-w-0 flex-1">
                                                                <div className="p-1.5 bg-[#FB8C00]/10 rounded">
                                                                    <Server className="w-4 h-4 text-[#FB8C00]" />
                                                                </div>
                                                                <div className="min-w-0 flex-1">
                                                                    <h4 className="font-semibold text-sm text-gray-900 truncate">
                                                                        {resource.resource_name || 'Sans nom'}
                                                                    </h4>
                                                                    <p className="text-xs text-gray-500 truncate">
                                                                        {service?.code || 'N/A'}
                                                                    </p>
                                                                </div>
                                                            </div>

                                                            {/* Center: Details */}
                                                            <div className="flex items-center gap-3 text-xs text-gray-600">
                                                                <div className="flex items-center gap-1">
                                                                    <Globe className="w-3.5 h-3.5 text-gray-400" />
                                                                    <span>{region?.code || 'N/A'}</span>
                                                                </div>
                                                                {instanceType && (
                                                                    <div className="flex items-center gap-1">
                                                                        <Cpu className="w-3.5 h-3.5 text-gray-400" />
                                                                        <span>{instanceType.name}</span>
                                                                    </div>
                                                                )}
                                                                {config?.quantity && (
                                                                    <div className="flex items-center gap-1">
                                                                        <span className="text-gray-400">×</span>
                                                                        <span>{config.quantity}</span>
                                                                    </div>
                                                                )}
                                                                {config?.hours_per_month && (
                                                                    <div className="flex items-center gap-1">
                                                                        <span className="text-gray-400">⏱</span>
                                                                        <span>{config.hours_per_month}h</span>
                                                                    </div>
                                                                )}
                                                            </div>

                                                            {/* Right: Price */}
                                                            <div className="text-right">
                                                                <p className="text-base font-bold text-[#FB8C00] whitespace-nowrap">
                                                                    ${parseFloat(resource.monthly_cost || 0).toFixed(2)}
                                                                </p>
                                                                <p className="text-xs text-gray-500">USD/mois</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                );
                                            })}
                                        </div>
                                    ) : (
                                        <div className="text-center py-6">
                                            <Server className="w-10 h-10 text-gray-300 mx-auto mb-2" />
                                            <span className="text-sm text-gray-400 italic">Aucune ressource définie</span>
                                        </div>
                                    )}
                                </div>

                                {selectedSimulation.entries && selectedSimulation.entries.length > 0 && (
                                    <div className="bg-gray-50 p-4 rounded-lg">
                                        <p className="text-xs text-gray-500 uppercase tracking-wide mb-2">Entrées</p>
                                        <div className="flex flex-wrap gap-2">
                                            {selectedSimulation.entries.map((entry, index) => (
                                                <span key={index}
                                                      className="px-3 py-1 bg-white border border-gray-200 rounded-full text-sm text-gray-700">
                                                    {entry}
                                                </span>
                                            ))}
                                        </div>
                                    </div>
                                )}

                                {/* Afficher toutes les autres propriétés de l'objet simulation */}
                                <details className="bg-gray-50 p-4 rounded-lg">
                                    <summary
                                        className="text-xs text-gray-500 uppercase tracking-wide cursor-pointer hover:text-gray-700">
                                        Voir toutes les données
                                    </summary>
                                    <pre
                                        className="mt-3 text-xs bg-white p-3 rounded border border-gray-200 overflow-x-auto">
                                        {JSON.stringify(selectedSimulation, null, 2)}
                                    </pre>
                                </details>
                            </div>
                        )}
                    </ModalComponent>

                    {loading && (
                        <p className="text-lg text-gray-600 animate-pulse">Chargement des données...</p>
                    )}
                    {error && <p className="text-lg text-red-600">{error}</p>}
                    {!loading && simulations.length === 0 && (
                        <p className="text-lg text-gray-500">Aucune simulation enregistrée pour le moment.</p>
                    )}

                    <div className="grid gap-6 sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
                        {simulations.map((sim) => (
                            <div
                                onClick={() => handleSimulationClick(sim)}
                                key={sim.id}
                                className="group bg-white rounded-2xl shadow-md p-6 border border-[#FB8C00]/20 hover:border-[#FB8C00] transition-all duration-300 cursor-pointer overflow-hidden relative"
                            >
                                <div
                                    className="absolute top-4 right-4 bg-[#FB8C00]/10 text-[#FB8C00] text-xs font-semibold px-3 py-1 rounded-full">
                                    #{sim.id}
                                </div>

                                <h2 className="text-2xl font-bold text-gray-900 mb-3 pr-12 group-hover:text-[#FB8C00] transition-colors">
                                    {sim.name}
                                </h2>

                                {/* Coût mensuel - élément principal */}
                                <div className="bg-[#FB8C00]/10 rounded-xl p-4 mb-4 border border-[#FB8C00]/20">
                                    <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">Coût mensuel</p>
                                    <p className="text-3xl font-bold text-[#FB8C00]">
                                        {Number.parseFloat(sim.monthly_coast).toFixed(2)}
                                        <span className="text-lg ml-1">USD</span>
                                    </p>
                                </div>

                                {/* Date de création */}
                                <div className="flex items-center text-sm text-gray-500">
                                    <svg className="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                                              d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                    </svg>
                                    {new Date(sim.created_at).toLocaleDateString('fr-FR')}
                                </div>

                                {/* Indicateur de clic */}
                                <div
                                    className="absolute bottom-4 right-4 text-[#FB8C00] opacity-0 group-hover:opacity-100 transition-opacity">
                                    <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2}
                                              d="M9 5l7 7-7 7"/>
                                    </svg>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </main>
        </>
    );
}