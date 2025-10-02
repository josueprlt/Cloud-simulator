import React from 'react';

const services = [
    {
        name: 'Amazon EC2',
        code: 'AmazonEC2',
        description:
        "Amazon Elastic Compute Cloud (EC2) fournit des serveurs virtuels évolutifs pour exécuter des applications dans le cloud. Idéal pour une capacité de calcul flexible et des configurations personnalisées.",
    },
    {
        name: 'AWS Lambda',
        code: 'AWSLambda',
        description:
        "AWS Lambda permet d'exécuter du code sans avoir à gérer de serveurs. Parfait pour les architectures orientées événements et les microservices.",
    },
    {
        name: 'Amazon RDS',
        code: 'AmazonRDS',
        description:
        "Amazon Relational Database Service (RDS) facilite la mise en place, l'exploitation et la montée en charge de bases de données relationnelles dans le cloud. Compatible avec MySQL, PostgreSQL et bien d'autres.",
    },
    {
        name: 'Amazon ECS',
        code: 'AmazonECS',
        description:
        "Amazon Elastic Container Service (ECS) est un service d'orchestration de conteneurs entièrement géré. Optimisé pour exécuter des conteneurs Docker à grande échelle.",
    },
    {
        name: 'Amazon EKS',
        code: 'AmazonEKS',
        description:
        "Amazon Elastic Kubernetes Service (EKS) est un service Kubernetes géré qui simplifie le déploiement, la gestion et la mise à l'échelle d'applications conteneurisées.",
    },
    {
        name: 'Amazon S3',
        code: 'AmazonS3',
        description:
        "Amazon Simple Storage Service (S3) offre un stockage d'objets sécurisé et évolutif pour la sauvegarde de données, l'archivage et la distribution de contenu.",
    },
];


export default function ServicesExplanation() {
    return (
        <div className="p-8 bg-gray-50 min-h-screen">
        <div className="max-w-5xl mx-auto space-y-8">
            <h1 className="text-3xl font-bold text-blue-800 border-b pb-2">
            Explication des services AWS
            </h1>

            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
            {services.map((service) => (
                <div
                key={service.code}
                className="bg-white rounded-xl shadow-md p-6 border border-gray-200 hover:shadow-lg transition"
                >
                <h2 className="text-xl font-semibold text-blue-700 mb-2">{service.name}</h2>
                <p className="text-sm text-gray-600">{service.description}</p>
                </div>
            ))}
            </div>
        </div>
        </div>
    );
}
