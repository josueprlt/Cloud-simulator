import { Link, useLocation } from 'react-router-dom';

export default function Header() {
    const location = useLocation();

    const navItems = [
        { name: 'Accueil', path: '/' },
        { name: 'Simulateur', path: '/simulator' },
        { name: 'Historique', path: '/history' },
        { name: 'Comparaison', path: '/comparaison' },
    ];

    return (
        <header className="bg-white shadow-md sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
            <Link to="/" className="text-2xl font-bold text-blue-700 hover:text-blue-900 transition">
            CloudSim
            </Link>

            <nav className="space-x-6">
            {navItems.map((item) => (
                <Link
                key={item.path}
                to={item.path}
                className={`text-sm font-medium ${
                    location.pathname === item.path
                    ? 'text-blue-600 border-b-2 border-blue-600 pb-1'
                    : 'text-gray-600 hover:text-blue-500'
                } transition`}
                >
                {item.name}
                </Link>
            ))}
            </nav>
        </div>
        </header>
    );
}
