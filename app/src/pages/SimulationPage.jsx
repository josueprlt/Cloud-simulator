import React from "react";
import FormComponent from "../views/AwsForm.jsx";
import Header from "./HeaderPart.jsx";

export default function SimulationPage() {
    document.title = 'Simulateur | CloudSim';
    return (
        <><Header /><FormComponent /></>
    );
}

