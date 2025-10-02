import {BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import DashboardPage from './pages/DashboardPage.jsx';
import HistoricPage from './pages/HistoricPage.jsx';
import SimulationPage from './pages/SimulationPage.jsx';

function App() {

    return (
        <>
            <Router>
                <Routes>
                    <Route path="/" element={<DashboardPage/>}/>
                    <Route path="/simulator" element={<SimulationPage/>}/>
                    <Route path="/results" element={<DashboardPage/>}/>
                    <Route path="/historic" element={<HistoricPage/>}/>
                </Routes>
            </Router>
        </>
    )
}

export default App

