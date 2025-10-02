import React from "react";
import {IconArrowClockWise, IconSimulation} from "./icons.jsx";

export function LastSimComponent({simulation, loading}) {
    console.log(simulation)
    return (
        <div className="p-6 space-y-6">
            <h3 className="text-xl text-[#808080] font-bold">Dernière simulation</h3>
            <div
                className="flex justify-center items-center flex-col gap-4 p-6 bg-white rounded-xl border border-gray-200 overflow-hidden">
                {loading && <IconArrowClockWise className="w-32 h-25 animate-spin"/>}
                {simulation === undefined ? (
                    <>
                        <IconSimulation className="w-32 h-25" fill="#D5D5D5"/>
                        <p className="text-[#D5D5D5] font-bold">Aucune simulation disponible</p>
                    </>
                ) : (
                    <div className="w-full space-y-4">
                        <div className="flex justify-between items-center border-b border-gray-200 pb-4">
                            <h4 className="text-2xl font-bold text-gray-900">{simulation.name}</h4>
                            <span className={`px-3 py-1 rounded-full text-sm font-semibold ${
                                simulation.status === 'active' ? 'bg-green-100 text-green-700' :
                                    simulation.status === 'archived' ? 'bg-yellow-100 text-yellow-700' :
                                        'bg-gray-100 text-gray-700'
                            }`}>
                                {simulation.status}
                            </span>
                        </div>

                        <div className="bg-[#FB8C00]/10 p-4 rounded-lg border border-[#FB8C00]/20">
                            <p className="text-sm text-gray-600 mb-1">Coût mensuel estimé</p>
                            <p className="text-3xl font-bold text-[#FB8C00]">{simulation.monthly_coast} €</p>
                        </div>

                        <div className="grid grid-cols-2 gap-4">
                            <div className="bg-gray-50 p-3 rounded-lg">
                                <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">Type de scénario</p>
                                <p className="text-sm font-semibold text-gray-900">{simulation.scenario_type}</p>
                            </div>

                            <div className="bg-gray-50 p-3 rounded-lg">
                                <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">Date de création</p>
                                <p className="text-sm font-semibold text-gray-900">
                                    {new Date(simulation.created_at).toLocaleDateString('fr-FR')}
                                </p>
                            </div>
                        </div>

                        {simulation.description && (
                            <div className="bg-gray-50 p-4 rounded-lg">
                                <p className="text-xs text-gray-500 uppercase tracking-wide mb-2">Description</p>
                                <p className="text-sm text-gray-700">{simulation.description}</p>
                            </div>
                        )}

                        <div className="bg-gray-50 p-4 rounded-lg">
                            <p className="text-xs text-gray-500 uppercase tracking-wide mb-2">Ressources utilisées</p>
                            <div className="flex flex-wrap gap-2">
                                {simulation.resources && simulation.resources.length > 0 ? (
                                    simulation.resources.map((resource, index) => (
                                        <span key={index}
                                              className="px-3 py-1 bg-white border border-gray-200 rounded-full text-sm text-gray-700">
                                            {resource}
                                        </span>
                                    ))
                                ) : (
                                    <span className="text-sm text-gray-400 italic">Aucune ressource définie</span>
                                )}
                            </div>
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
}