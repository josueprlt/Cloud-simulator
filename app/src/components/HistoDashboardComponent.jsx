import { Link } from 'react-router-dom';
import { Calendar, Tag } from 'lucide-react';

export function HistoDashboardComponent({simulations}) {
    return (
        <div className="p-6 space-y-6 text-center">
            <h3 className="text-xl text-[#808080] font-bold">Historique des simulations</h3>
            <div className="flex justify-center items-center flex-col gap-4 p-6 bg-white border-gray-200 overflow-hidden">
                <div className="bg-gray-50 p-4 rounded-lg w-300">
                    <p className="text-xs text-gray-500 uppercase tracking-wide mb-3 text-left">Dernières simulations ({Math.min(simulations.length, 3)})</p>
                    {simulations.length === 0 ? (
                        <div className="text-center py-8">
                            <Tag className="w-10 h-10 text-gray-300 mx-auto mb-2" />
                            <span className="text-sm text-gray-400 italic">Aucune simulation disponible</span>
                        </div>
                    ) : (
                        <div className="space-y-2">
                            {simulations.slice(0, 3).map((item, index) => (
                                <div key={index} className="bg-white border border-gray-200 rounded-lg p-3 hover:border-[#FB8C00]/50 transition-all">
                                    <div className="flex items-center justify-between gap-3">
                                        {/* Left: ID + Name */}
                                        <div className="flex items-center gap-3 min-w-0 flex-1">
                                            <div className="flex items-center justify-center w-10 h-10 bg-[#FB8C00]/10 rounded text-[#FB8C00] font-bold text-sm">
                                                #{item.id}
                                            </div>
                                            <div className="min-w-0 flex-1">
                                                <h4 className="font-semibold text-sm text-gray-900 truncate">{item.name}</h4>
                                                <p className="text-xs text-gray-500 truncate">Simulation {item.scenario_type || 'standard'}</p>
                                            </div>
                                        </div>

                                        {/* Center: Date */}
                                        <div className="flex items-center gap-2 text-xs text-gray-600">
                                            <Calendar className="w-3.5 h-3.5 text-gray-400" />
                                            <span>{new Date(item.created_at).toLocaleDateString('fr-FR')}</span>
                                        </div>

                                        {/* Right: Status */}
                                        <div className="text-right">
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    )}
                </div>
                <Link className="bg-[#FB8C00] hover:bg-[#FB8C00]/70 text-white text-center font-bold py-2 px-4 rounded transition-colors" to="/history">
                    Voir plus
                </Link>
            </div>
        </div>
    );
}