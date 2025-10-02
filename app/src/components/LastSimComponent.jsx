import React, { useEffect, useState } from 'react';
import { DirectusDatas } from '../services/getDatas.js';

export function LastSimComponent() {
    const [recentSimulations, setRecentSimulations] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        async function fetchRecentSimulations() {
        try {
            const sims = await DirectusDatas.getSimulations();
            const sorted = sims
            .sort((a, b) => new Date(b.created_at) - new Date(a.created_at))
            .slice(0, 3);
            setRecentSimulations(sorted);
        } catch (error) {
            console.error('Erreur chargement simulations:', error);
        } finally {
            setLoading(false);
        }
        }

        fetchRecentSimulations();
    }, []);

    return (
        <div className="p-6 space-y-6">
        <h3 className="text-xl text-gray-600 font-bold">Vos 3 dernières simulations</h3>

        {loading ? (
            <p className="text-gray-400">Chargement...</p>
        ) : recentSimulations.length === 0 ? (
            <div className="flex justify-center items-center flex-col gap-4 p-6 bg-white rounded-xl border border-gray-200 overflow-hidden">
            <p className="text-[#D5D5D5] font-bold">Aucune simulation disponible</p>
            </div>
        ) : (
            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {recentSimulations.map((sim) => (
                <div
                key={sim.id}
                className="bg-white rounded-xl shadow-md p-5 border border-gray-100 hover:shadow-lg transition"
                >
                <h4 className="text-lg font-semibold text-blue-700">{sim.name}</h4>
                <p className="text-sm text-gray-600">
                    Créé le: {new Date(sim.created_at).toLocaleDateString('fr-FR')}
                </p>
                <p className="text-sm text-gray-600">
                    Coût mensuel: {sim.monthly_cost ?? 'N/A'} €
                </p>
                <p className="text-sm text-gray-600">
                    Région: {sim.region ?? 'Non spécifiée'}
                </p>
                </div>
            ))}
            </div>
        )}
        </div>
    );
}
