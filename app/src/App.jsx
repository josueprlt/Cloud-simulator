import {BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import DashboardPage from './pages/DashboardPage.jsx';
import SimulatorPage from './pages/SimulatorPage.jsx';
import HistoricPage from './pages/HistoricPage.jsx';

function App() {

    return (
        <>
            <Router>
                <Routes>
                    <Route path="/" element={<DashboardPage/>}/>
                    <Route path="/simulator" element={<SimulatorPage/>}/>
                    <Route path="/historic" element={<HistoricPage/>}/>
                </Routes>
            </Router>
        </>
    )
}

export default App


