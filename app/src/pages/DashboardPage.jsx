import React from "react";
import { LastSimComponent } from "../components/LastSimComponent.jsx";
import { HistoDashboardComponent } from "../components/HistoDashboardComponent.jsx";
import Header from "./HeaderPart.jsx";

function DashboardPage() {
    document.title = "Accueil | CloudSim";

    return (
        <>
        <Header />

        <main className="bg-gray-50 min-h-screen">
            <div className="bg-gradient-to-b from-[#FB8C00]/20 to-white py-10 px-6">
            <h1 className="text-center font-bold text-4xl text-[#FB8C00]">
                Cloud Cost Simulator
            </h1>
            </div>

            <div className="max-w-6xl mx-auto px-6 py-6 space-y-8">
            <div className="flex justify-center">
                <a
                className="bg-[#FB8C00] hover:bg-[#FB8C00]/70 text-white font-bold py-2 px-6 rounded shadow"
                href="/simulator"
                >
                Lancer une simulation
                </a>
            </div>

            <section className="bg-white rounded-xl shadow-md p-6">
                <LastSimComponent />
            </section>

            <section className="bg-white rounded-xl shadow-md p-6">
                <HistoDashboardComponent />
            </section>
            </div>
        </main>
        </>
    );
}

export default DashboardPage;
