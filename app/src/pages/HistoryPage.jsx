import { useEffect, useState } from 'react';
import { DirectusDatas } from '../services/getDatas.js';
import Header from './HeaderPart.jsx';

export default function HistoryPage() {
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

    return (
        <>
        <Header />

      <main className="min-h-screen bg-gradient-to-br from-[#FB8C00]/20 to-[#FB8C00]/0 p-8">
            <div className="max-w-7xl mx-auto space-y-8">
            <h1 className="text-4xl font-extrabold text-blue-900 border-b pb-2">
                Historique des simulations
            </h1>

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
                    key={sim.id}
                    className="bg-white rounded-xl shadow-md p-6 border border-gray-200 hover:shadow-lg transition-shadow duration-300"
                >
                    <h2 className="text-xl font-semibold text-blue-700 mb-2">{sim.name}</h2>
                    <p className="text-sm text-gray-600">
                    Région : <span className="font-medium">{sim.region || 'Non spécifiée'}</span>
                    </p>
                    <p className="text-sm text-gray-600">
                    Créé le :{' '}
                    <span className="font-medium">
                        {new Date(sim.created_at).toLocaleDateString('fr-FR')}
                    </span>
                    </p>
                    {sim.entries && sim.entries.length > 0 && (
                    <p className="text-sm text-gray-600">
                        Ressources :{' '}
                        <span className="font-medium">{sim.entries.join(', ')}</span>
                    </p>
                    )}
                </div>
                ))}
            </div>
            </div>
        </main>
        </>
    );
}
