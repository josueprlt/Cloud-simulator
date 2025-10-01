import {BrowserRouter as Router, Routes, Route} from 'react-router-dom';
import DashboardPage from './pages/DashboardPage.jsx';

function App() {

    return (
        <>
            <Router>
                <Routes>
                    <Route path="/" element={<DashboardPage/>}/>
                    <Route path="/simulator" element={<DashboardPage/>}/>
                    <Route path="/results" element={<DashboardPage/>}/>
                    <Route path="/historic" element={<DashboardPage/>}/>
                </Routes>
            </Router>
        </>
    )
}

export default App


