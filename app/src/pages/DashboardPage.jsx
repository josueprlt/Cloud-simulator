import React, {useEffect, useState} from "react";
import {LastSimComponent} from "../components/LastSimComponent.jsx";
import {HistoDashboardComponent} from "../components/HistoDashboardComponent.jsx";
import Header from "./HeaderPart.jsx";
import {DirectusDatas} from "../services/getDatas.js";

function DashboardPage() {
    const [simulations, setSimulations] = useState([]);
    const [lastSimulation, setLastSimulation] = useState([]);
    const [lastSimResources, setLastSimResources] = useState([]);
    const [services, setServices] = useState([]);
    const [regions, setRegions] = useState([]);
    const [instanceTypes, setInstanceTypes] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        document.title = 'Historique | CloudSim';

        async function fetchSimulations() {
            try {
                const [simsData, servicesData, regionsData, instanceTypesData] = await Promise.all([
                    DirectusDatas.getSimulations(),
                    DirectusDatas.getServices(),
                    DirectusDatas.getRegions(),
                    DirectusDatas.getInstanceType()
                ]);

                setSimulations(simsData);
                setServices(servicesData);
                setRegions(regionsData);
                setInstanceTypes(instanceTypesData);

                if (simsData && simsData.length > 0) {
                    const mostRecent = simsData.reduce((latest, current) => {
                        const latestDate = new Date(latest.created_at);
                        const currentDate = new Date(current.created_at);
                        return currentDate > latestDate ? current : latest;
                    });
                    setLastSimulation(mostRecent);

                    // Charger les ressources de la dernière simulation
                    const resources = await DirectusDatas.getResourcesBySimulation(mostRecent.id);
                    setLastSimResources(resources);
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

            <LastSimComponent
                simulation={lastSimulation}
                resources={lastSimResources}
                services={services}
                regions={regions}
                instanceTypes={instanceTypes}
                loading={loading}
            />

            <HistoDashboardComponent simulations={simulations} loading={loading}/>
        </>
    );
}

export default DashboardPage;