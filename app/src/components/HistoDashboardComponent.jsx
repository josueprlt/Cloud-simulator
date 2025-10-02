import React from "react";
import {IconArrowClockWise} from "./icons.jsx";

export function HistoDashboardComponent({simulations, loading}) {
    return (
        <div className="p-6 space-y-6">
            <h3 className="text-xl text-[#808080] font-bold">Historique</h3>
            <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
                <div className="overflow-x-auto">
                    <table className="min-w-full border-separate border-spacing-0">
                        <thead className="bg-gray-50">
                        <tr>
                            <th className="sticky top-0 z-10 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide px-4 py-3 border-b border-gray-200">ID</th>
                            <th className="sticky top-0 z-10 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide px-4 py-3 border-b border-gray-200">Nom</th>
                            <th className="sticky top-0 z-10 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide px-4 py-3 border-b border-gray-200">Créé
                                le
                            </th>
                            <th className="sticky top-0 z-10 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide px-4 py-3 border-b border-gray-200">Status</th>
                        </tr>
                        </thead>
                        <tbody className="[&>tr:hover]:bg-gray-50">
                        {simulations.length === 0 ? (
                            <tr>
                                <td colSpan="4" className="text-center py-4 text-[#D5D5D5] font-bold">Aucune simulation
                                    disponible
                                </td>
                            </tr>
                        ) : (
                            simulations.map((item, index) => (
                                index < 3 && (
                                    <tr key={index} className="transition-colors">
                                        <td className="px-4 py-3 text-sm text-gray-900 border-b border-gray-100">{item.id}</td>
                                        <td className="px-4 py-3 text-sm text-gray-900 border-b border-gray-100">{item.name}</td>
                                        <td className="px-4 py-3 text-sm text-gray-600 border-b border-gray-100">{item.created_at}</td>
                                        <td className="px-4 py-3 text-sm text-gray-900 border-b border-gray-100">{item.status}</td>
                                    </tr>
                                )
                            ))
                        )}
                        </tbody>
                    </table>
                </div>
            </div>
            <div className="flex justify-center">
                <a className="bg-[#FB8C00] hover:bg-[#FB8C00]/70 text-white font-bold py-2 px-4 rounded"
                   href="/history">Voir plus</a>
            </div>
        </div>
    );
}