import React, {useEffect, useState} from "react";
import {LastSimComponent} from "../components/LastSimComponent.jsx";
import {HistoDashboardComponent} from "../components/HistoDashboardComponent.jsx";
import Header from "./HeaderPart.jsx";
import {DirectusDatas} from "../services/getDatas.js";

function DashboardPage() {
    const [simulations, setSimulations] = useState([]);
    const [lastSimulation, setLastSimulation] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        document.title = 'Historique | CloudSim';

        async function fetchSimulations() {
            try {
                const data = await DirectusDatas.getSimulations();
                setSimulations(data);

                if (data && data.length > 0) {
                    const mostRecent = data.reduce((latest, current) => {
                        const latestDate = new Date(latest.created_at);
                        const currentDate = new Date(current.created_at);
                        return currentDate > latestDate ? current : latest;
                    });
                    setLastSimulation(mostRecent);
                }
            } catch (err) {
                setError('Erreur lors du chargement des simulations.');
            } finally {
                setLoading(false);
            }
        }

        fetchSimulations();
    }, []);

    return (
        <>  <Header/>
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

            <LastSimComponent simulation={lastSimulation} loading={loading} />

            <HistoDashboardComponent simulations={simulations} loading={loading}/>
        </>
    );
}

export default DashboardPage;