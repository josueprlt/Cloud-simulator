import {BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import DashboardPage from './pages/DashboardPage.jsx';
import HistoryPage from './pages/HistoryPage.jsx';
import SimulationPage from './pages/SimulationPage.jsx';
import ComparisonPage from './pages/ComparaisonPage.jsx';


function App() {

    return (
        <>
            <Router>
                <Routes>
                    <Route path="/" element={<DashboardPage/>}/>
                    <Route path="/simulator" element={<SimulationPage/>}/>
                    <Route path="/history" element={<HistoryPage/>}/>
                    <Route path="/comparaison" element={<ComparisonPage/>}/>
                </Routes>
            </Router>
        </>
    )
}

export default App
