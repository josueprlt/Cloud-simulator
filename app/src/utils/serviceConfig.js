// Configuration des exigences et caractéristiques par service AWS

export const SERVICE_REQUIREMENTS = {
  'EC2': {
    name: 'Amazon EC2',
    category: 'Compute',
    requiresInstanceType: true,
    requiresOS: true,
    configurableFields: ['quantity', 'hours_per_month'],
    pricingUnit: 'Instance Hours',
    icon: '🖥️'
  },
  'RDS': {
    name: 'Amazon RDS',
    category: 'Database',
    requiresInstanceType: true,
    requiresEngine: true,
    configurableFields: ['quantity', 'hours_per_month', 'storage_gb'],
    pricingUnit: 'Instance Hours',
    icon: '🗄️'
  },
  'ECS': {
    name: 'Amazon ECS',
    category: 'Compute',
    requiresLaunchType: true, // Fargate vs EC2
    configurableFields: ['quantity', 'hours_per_month', 'vcpu', 'memory_gb'],
    pricingUnit: 'Task Hours',
    icon: '📦'
  },
  'EKS': {
    name: 'Amazon EKS',
    category: 'Compute',
    requiresInstanceType: false, // Control plane coût fixe
    configurableFields: ['clusters', 'hours_per_month'],
    pricingUnit: 'Cluster Hours',
    icon: '☸️'
  },
  'Lambda': {
    name: 'AWS Lambda',
    category: 'Compute',
    requiresInstanceType: false,
    configurableFields: ['invocations', 'memory_mb', 'duration_ms'],
    pricingUnit: 'Invocations',
    icon: '⚡'
  },
  'S3': {
    name: 'Amazon S3',
    category: 'Storage',
    requiresInstanceType: false,
    configurableFields: ['storage_gb', 'requests', 'transfer_gb'],
    pricingUnit: 'GB-Month',
    icon: '🪣'
  },
  'DynamoDB': {
    name: 'Amazon DynamoDB',
    category: 'Database',
    requiresInstanceType: false,
    configurableFields: ['rcu', 'wcu', 'storage_gb'],
    pricingUnit: 'RCU/WCU',
    icon: '⚡'
  },
  'CloudFront': {
    name: 'Amazon CloudFront',
    category: 'Network',
    requiresInstanceType: false,
    configurableFields: ['transfer_gb', 'requests'],
    pricingUnit: 'GB Transfer',
    icon: '🌐'
  }
};

export const SERVICE_CATEGORIES = {
  'Compute': {
    name: 'Calcul',
    color: 'orange',
    bgColor: 'bg-orange-100',
    textColor: 'text-orange-700',
    borderColor: 'border-orange-300'
  },
  'Storage': {
    name: 'Stockage',
    color: 'blue',
    bgColor: 'bg-blue-100',
    textColor: 'text-blue-700',
    borderColor: 'border-blue-300'
  },
  'Database': {
    name: 'Base de données',
    color: 'purple',
    bgColor: 'bg-purple-100',
    textColor: 'text-purple-700',
    borderColor: 'border-purple-300'
  },
  'Network': {
    name: 'Réseau',
    color: 'green',
    bgColor: 'bg-green-100',
    textColor: 'text-green-700',
    borderColor: 'border-green-300'
  }
};

// Obtenir la configuration d'un service
export function getServiceConfig(serviceCode) {
  return SERVICE_REQUIREMENTS[serviceCode] || {
    name: serviceCode,
    category: 'Other',
    requiresInstanceType: false,
    configurableFields: ['quantity', 'hours_per_month'],
    pricingUnit: 'Units',
    icon: '📊'
  };
}

// Vérifier si un service nécessite un type d'instance
export function requiresInstanceType(serviceCode) {
  return SERVICE_REQUIREMENTS[serviceCode]?.requiresInstanceType || false;
}

// Grouper des ressources par catégorie
export function groupResourcesByCategory(resources, services) {
  const grouped = {};

  resources.forEach(resource => {
    const service = services.find(s => s.id === resource.service);
    const serviceCode = service?.code || 'Other';
    const config = getServiceConfig(serviceCode);
    const category = config.category;

    if (!grouped[category]) {
      grouped[category] = {
        resources: [],
        totalCost: 0
      };
    }

    grouped[category].resources.push({
      ...resource,
      serviceConfig: config,
      serviceName: service?.name || serviceCode
    });
    grouped[category].totalCost += parseFloat(resource.monthly_cost || 0);
  });

  return grouped;
}

// Calculer les métriques de comparaison
export function calculateComparisonMetrics(sim1Resources, sim2Resources, services) {
  const sim1Grouped = groupResourcesByCategory(sim1Resources, services);
  const sim2Grouped = groupResourcesByCategory(sim2Resources, services);

  const sim1Total = Object.values(sim1Grouped).reduce((sum, cat) => sum + cat.totalCost, 0);
  const sim2Total = Object.values(sim2Grouped).reduce((sum, cat) => sum + cat.totalCost, 0);

  const savings = sim1Total - sim2Total;
  const savingsPercent = sim1Total > 0 ? ((savings / sim1Total) * 100) : 0;

  return {
    sim1Grouped,
    sim2Grouped,
    sim1Total,
    sim2Total,
    savings,
    savingsPercent,
    cheaperSimulation: sim1Total < sim2Total ? 1 : 2
  };
}
