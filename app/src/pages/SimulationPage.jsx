import React from "react";
import FormComponent from "../components/SimulatorFormComponent.jsx";
import Header from "./HeaderPart.jsx";
import ServicesExplanation from "../components/ServicesExplanation.jsx";
import Comparaison from "./ComparaisonPage.jsx";

export default function SimulationPage() {
    document.title = "Simulateur | CloudSim";

    return (
        <>
        <Header />
        <main className="bg-gradient-to-b from-gray-50 to-white min-h-screen px-6 py-10">
        <div className="max-w-5xl mx-auto space-y-10">

            {/* Simulation Form */}
            <section className="bg-white rounded-2xl shadow-md border border-gray-100 overflow-hidden">
                <FormComponent />
            </section>

            {/* AWS Services Explanation */}
            <section className="bg-white rounded-2xl shadow-md border border-gray-100 p-8 max-h-[60vh] overflow-hidden">
                <ServicesExplanation />
            </section>
            </div>
        </main>
        </>
    );
}
