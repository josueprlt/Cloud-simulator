import React from "react";

export function HistoDashboardComponent() {
    const [data, setData] = React.useState([
        {
            id: 1,
            name: 'Production Cluster',
            created_date: '2025-09-15',
            user: 'Pierrick'
        },
        {
            id: 2,
            name: 'New Cluster Prod',
            created_date: '2024-08-05',
            user: 'test'
        },
        {
            id: 3,
            name: 'New Cluster Prod 2',
            created_date: '2025-10-17',
            user: 'test2'
        }
    ])

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
                            <th className="sticky top-0 z-10 text-left text-xs font-semibold text-gray-500 uppercase tracking-wide px-4 py-3 border-b border-gray-200">Utilisateur</th>
                        </tr>
                        </thead>
                        <tbody className="[&>tr:hover]:bg-gray-50">
                        {data.length === 0 ? (
                            <tr>
                                <td colSpan="4" className="text-center py-4 text-[#D5D5D5] font-bold">Aucune simulation
                                    disponible
                                </td>
                            </tr>
                        ) : (
                            data.map(item => (
                                <tr className="transition-colors">
                                    <td className="px-4 py-3 text-sm text-gray-900 border-b border-gray-100">{item.id}</td>
                                    <td className="px-4 py-3 text-sm text-gray-900 border-b border-gray-100">{item.name}</td>
                                    <td className="px-4 py-3 text-sm text-gray-600 border-b border-gray-100">{item.created_date}</td>
                                    <td className="px-4 py-3 text-sm text-gray-900 border-b border-gray-100">{item.user}</td>
                                </tr>
                            ))
                        )}
                        </tbody>
                    </table>
                </div>
            </div>
            <div className="flex justify-center">
                <a className="bg-[#FB8C00] hover:bg-[#FB8C00]/70 text-white font-bold py-2 px-4 rounded"
                   href="/historic">Voir plus</a>
            </div>
        </div>
    );
}