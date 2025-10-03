import {useEffect, useState} from 'react';
import {DirectusDatas} from '../services/getDatas.js';
import Header from './HeaderPart.jsx';
import ModalComponent from '../components/ModalComponent.jsx';

export default function HistoryPage() {
    const [open, setOpen] = useState(false);
    const [selectedSimulation, setSelectedSimulation] = useState(null);

    const [simulations, setSimulations] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        document.title = 'Historique | CloudSim';

        async function fetchSimulations() {
            try {
                const data = await DirectusDatas.getSimulations();
                setSimulations(data);
            } catch (err) {
                setError('Erreur lors du chargement des simulations.');
            } finally {
                setLoading(false);
            }
        }

        fetchSimulations();
    }, []);

    const handleSimulationClick = (simulation) => {
        setSelectedSimulation(simulation);
        setOpen(true);
    };

    console.log(simulations)
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

                                {selectedSimulation.resources && selectedSimulation.resources.length > 0 && (
                                    <div className="bg-gray-50 p-4 rounded-lg">
                                        <p className="text-xs text-gray-500 uppercase tracking-wide mb-2">Ressources
                                            utilisées</p>
                                        <div className="flex flex-wrap gap-2">
                                            {selectedSimulation.resources.map((resource, index) => (
                                                <span key={index}
                                                      className="px-3 py-1 bg-white border border-gray-200 rounded-full text-sm text-gray-700">
                                                    {resource}
                                                </span>
                                            ))}
                                        </div>
                                    </div>
                                )}

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