import {BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import DashboardPage from './pages/DashboardPage.jsx';
import HistoryPage from './pages/HistoryPage.jsx';
import SimulationPage from './pages/SimulationPage.jsx';

function App() {

    return (
        <>
            <Router>
                <Routes>
                    <Route path="/" element={<DashboardPage/>}/>
                    <Route path="/simulator" element={<SimulationPage/>}/>
                    <Route path="/history" element={<HistoryPage/>}/>
                </Routes>
            </Router>
        </>
    )
}

export default App

