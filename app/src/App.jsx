import ChartComponent from "./components/ChartComponent"
import FormComponent from "./views/AwsForm"

function App() {

    return (
        <>
            <FormComponent />
            <div className="flex justify-center">
                <div className="w-1/2 bg-white p-4">
                </div>
            </div>
            <ChartComponent/>
        </>
    )
}

export default App
