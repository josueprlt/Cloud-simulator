import React from "react";
import {IconArrowClockWise, IconSimulation} from "./icons.jsx";
import { Server, Globe, Cpu, HardDrive } from 'lucide-react';

export function LastSimComponent({simulation, resources = [], services = [], regions = [], instanceTypes = [], loading}) {
    return (
        <div className="p-6 space-y-6 text-center">
            <h3 className="text-xl text-[#808080] font-bold">Dernière simulation</h3>
            <div
                className="flex justify-center items-center flex-col gap-4 p-6 bg-white border-gray-200 overflow-hidden">
                {loading && <IconArrowClockWise className="w-32 h-25 animate-spin"/>}
                {simulation === undefined ? (
                    <>
                        <IconSimulation className="w-32 h-25" fill="#D5D5D5"/>
                        <p className="text-[#D5D5D5] font-bold">Aucune simulation disponible</p>
                    </>
                ) : (
                    <div className="w-300 space-y-4">
                        <div className="flex justify-between items-center border-b border-gray-200 pb-4">
                            <h4 className="text-lg font-bold text-[#372c2c]">Simulation name : {simulation.name}</h4>
                        </div>

                        <div className="bg-[#FB8C00]/10 p-4 rounded-lg border border-[#FB8C00]/20">
                            <p className="text-sm text-gray-600 mb-1">Coût mensuel estimé</p>
                            <p className="text-3xl font-bold text-[#FB8C00]">${parseFloat(simulation.monthly_coast || 0).toFixed(2)} USD</p>
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
                            <p className="text-xs text-gray-500 uppercase tracking-wide mb-3">Ressources utilisées ({resources.length})</p>
                            {resources && resources.length > 0 ? (
                                <div className="space-y-3">
                                    {resources.map((resource, index) => {
                                        const service = services.find(s => s.id === resource.service);
                                        const region = regions.find(r => r.id === resource.region);
                                        const instanceType = instanceTypes.find(it => it.id === resource.instance_types);
                                        const config = typeof resource.configuration === 'string'
                                            ? JSON.parse(resource.configuration)
                                            : resource.configuration;

                                        return (
                                            <div key={index} className="bg-white border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow">
                                                <div className="flex items-start justify-between mb-3">
                                                    <div className="flex items-center gap-2">
                                                        <div className="p-2 bg-[#FB8C00]/10 rounded-lg">
                                                            <Server className="w-5 h-5 text-[#FB8C00]" />
                                                        </div>
                                                        <div>
                                                            <h4 className="font-semibold text-gray-900">{resource.resource_name || 'Sans nom'}</h4>
                                                            <p className="text-xs text-gray-500">{service?.code || 'N/A'} • {service?.name || 'Service inconnu'}</p>
                                                        </div>
                                                    </div>
                                                    <div className="text-right">
                                                        <p className="text-lg font-bold text-[#FB8C00]">${parseFloat(resource.monthly_cost || 0).toFixed(2)}</p>
                                                        <p className="text-xs text-gray-500">USD/mois</p>
                                                    </div>
                                                </div>

                                                <div className="grid grid-cols-2 gap-3 mt-3 pt-3 border-t border-gray-100">
                                                    <div className="flex items-center gap-2">
                                                        <Globe className="w-4 h-4 text-gray-400" />
                                                        <div>
                                                            <p className="text-xs text-gray-500">Région</p>
                                                            <p className="text-sm font-medium text-gray-700">{region?.code || 'N/A'}</p>
                                                        </div>
                                                    </div>

                                                    {instanceType && (
                                                        <div className="flex items-center gap-2">
                                                            <Cpu className="w-4 h-4 text-gray-400" />
                                                            <div>
                                                                <p className="text-xs text-gray-500">Type d'instance</p>
                                                                <p className="text-sm font-medium text-gray-700">{instanceType.name}</p>
                                                            </div>
                                                        </div>
                                                    )}

                                                    {config?.quantity && (
                                                        <div className="flex items-center gap-2">
                                                            <HardDrive className="w-4 h-4 text-gray-400" />
                                                            <div>
                                                                <p className="text-xs text-gray-500">Quantité</p>
                                                                <p className="text-sm font-medium text-gray-700">{config.quantity} unité(s)</p>
                                                            </div>
                                                        </div>
                                                    )}

                                                    {config?.hours_per_month && (
                                                        <div className="flex items-center gap-2">
                                                            <div className="w-4 h-4 flex items-center justify-center">
                                                                <span className="text-xs text-gray-400">⏱</span>
                                                            </div>
                                                            <div>
                                                                <p className="text-xs text-gray-500">Heures/mois</p>
                                                                <p className="text-sm font-medium text-gray-700">{config.hours_per_month}h</p>
                                                            </div>
                                                        </div>
                                                    )}
                                                </div>

                                                {resource.unit_price && (
                                                    <div className="mt-3 pt-3 border-t border-gray-100">
                                                        <p className="text-xs text-gray-500">
                                                            Prix unitaire: <span className="font-medium text-gray-700">${parseFloat(resource.unit_price).toFixed(4)}/heure</span>
                                                        </p>
                                                    </div>
                                                )}
                                            </div>
                                        );
                                    })}
                                </div>
                            ) : (
                                <div className="text-center py-8">
                                    <Server className="w-12 h-12 text-gray-300 mx-auto mb-2" />
                                    <span className="text-sm text-gray-400 italic">Aucune ressource définie</span>
                                </div>
                            )}
                        </div>
                    </div>
                )}
            </div>
        </div>
    );
}