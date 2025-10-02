import React from "react";
import {IconSimulation} from "./icons.jsx";

export function LastSimComponent() {
    return (
        <div className="p-6 space-y-6">
            <h3 className="text-xl text-[#808080] font-bold">Dernière simulation</h3>
            <div
                className="flex justify-center items-center flex-col gap-4 p-6 bg-white rounded-xl border border-gray-200 overflow-hidden">
                <IconSimulation className="w-32 h-25" fill="#D5D5D5"/>
                <p className="text-[#D5D5D5] font-bold">Aucune simulation disponible</p>
            </div>
        </div>
    );
}