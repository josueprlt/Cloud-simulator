import React from "react";
import {LastSimComponent} from "../components/LastSimComponent.jsx";
import {HistoDashboardComponent} from "../components/HistoDashboardComponent.jsx";
import Header from "./HeaderPart.jsx";

function DashboardPage() {
    return (
        <>  <Header />
            <div className="p-22 bg-gradient-to-b from-[#FB8C00]/20 to-white">
                <h1 className="text-center font-bold text-4xl text-[#FB8C00]">
                    Cloud Cost Simulator
                </h1>
            </div>

            <div className="p-6 space-y-6">
                <div className="flex justify-center">
                    <a className="bg-[#FB8C00] hover:bg-[#FB8C00]/70 text-white font-bold py-2 px-4 rounded"
                       href="/simulator">Lancer une simulation</a>
                </div>
            </div>

            <LastSimComponent/>

            <HistoDashboardComponent/>
        </>
    );
}

export default DashboardPage;