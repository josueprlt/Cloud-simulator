import { useEffect, useState } from 'react';
import { DirectusDatas } from '../services/getDatas.js';

export default function HistoricPage() {
    const [simulations, setSimulations] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
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
        <div className="p-6 space-y-6 bg-gray-50 min-h-screen">
        <h1 className="text-3xl font-bold text-gray-800">Historique des simulations</h1>

        {loading && <p className="text-gray-500">Chargement des données...</p>}
        {error && <p className="text-red-500">{error}</p>}
        {!loading && simulations.length === 0 && (
            <p className="text-gray-500">Aucune simulation enregistrée pour le moment.</p>
        )}

        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {simulations.map((sim) => (
            <div
                key={sim.id}
                className="bg-white rounded-lg shadow-md p-5 hover:shadow-lg transition-shadow"
            >
                <h2 className="text-xl font-semibold text-blue-700">{sim.name}</h2>
                <p className="text-sm text-gray-600">Région: {sim.region}</p>
            </div>
            ))}
        </div>
        </div>
    );
}
