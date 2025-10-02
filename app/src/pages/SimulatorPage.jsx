import React from "react";
import FormComponent from "../components/form/AwsForm.jsx";

function HistoricPage() {
    return (
        <div className="p-6 space-y-6">
            <h1 className="text-2xl font-bold">Simulator place</h1>

            <div className="flex justify-center">
                <div className="w-1/2 bg-white p-4">
                    <FormComponent/>
                </div>
            </div>
        </div>
    );
}

export default HistoricPage;
