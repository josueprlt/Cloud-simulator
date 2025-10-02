import ChartComponent from "./components/ChartComponent"
import AwsForm from "./views/AwsForm"
function App() {

    return (
        <>
            <AwsForm />
            <div className="flex justify-center">
                <div className="w-1/2 bg-white p-4">
                </div>
            </div>
            <ChartComponent/>
        </>
    )
}

export default App
