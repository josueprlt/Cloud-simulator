// src/utils/export.js
import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';
import Papa from 'papaparse';

/**
 * Exporte une simulation en CSV
 */
export function exportSimulationToCSV(simulation, resources) {
  const csvData = resources.map(resource => ({
    'Nom de la ressource': resource.resource_name || 'N/A',
    'Service': resource.service?.name || resource.service,
    'Région': resource.region?.name || resource.region,
    'Type d\'instance': resource.instance_type?.name || resource.instance_type || 'N/A',
    'Quantité': resource.configuration?.quantity || 0,
    'Heures/mois': resource.configuration?.hours_per_month || 0,
    'Système': resource.configuration?.os || 'N/A',
    'Prix unitaire ($/h)': resource.unit_price || 0,
    'Coût mensuel ($)': resource.monthly_cost || 0
  }));

  // Ajouter une ligne de total
  const totalCost = resources.reduce((sum, r) => sum + parseFloat(r.monthly_cost || 0), 0);
  csvData.push({
    'Nom de la ressource': 'TOTAL',
    'Service': '',
    'Région': '',
    'Type d\'instance': '',
    'Quantité': '',
    'Heures/mois': '',
    'Système': '',
    'Prix unitaire ($/h)': '',
    'Coût mensuel ($)': totalCost.toFixed(2)
  });

  const csv = Papa.unparse(csvData);
  
  // Télécharger le fichier
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
  const link = document.createElement('a');
  const url = URL.createObjectURL(blob);
  
  link.setAttribute('href', url);
  link.setAttribute('download', `simulation-${simulation.name.replace(/\s+/g, '-')}-${Date.now()}.csv`);
  link.style.visibility = 'hidden';
  
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
}

/**
 * Exporte une simulation en PDF
 */
export function exportSimulationToPDF(simulation, resources) {
  const doc = new jsPDF();
  
  // En-tête
  doc.setFontSize(20);
  doc.setTextColor(79, 70, 229); // Indigo-600
  doc.text('Simulation AWS - Estimation des Coûts', 14, 22);
  
  doc.setFontSize(12);
  doc.setTextColor(0, 0, 0);
  doc.text(`Nom: ${simulation.name}`, 14, 32);
  
  if (simulation.description) {
    doc.setFontSize(10);
    doc.setTextColor(100, 100, 100);
    doc.text(`Description: ${simulation.description}`, 14, 38);
  }
  
  doc.setFontSize(10);
  doc.text(`Date: ${new Date().toLocaleDateString('fr-FR')}`, 14, simulation.description ? 44 : 38);
  
  // Ligne de séparation
  const startY = simulation.description ? 50 : 44;
  doc.setDrawColor(200, 200, 200);
  doc.line(14, startY, 196, startY);
  
  // Tableau des ressources
  const tableData = resources.map(resource => [
    resource.resource_name || 'N/A',
    resource.service?.name || resource.service || 'N/A',
    resource.region?.name || resource.region || 'N/A',
    resource.instance_type?.name || resource.instance_type || 'N/A',
    resource.configuration?.quantity || 0,
    resource.configuration?.hours_per_month || 0,
    `$${parseFloat(resource.monthly_cost || 0).toFixed(2)}`
  ]);
  
  autoTable(doc, {
    startY: startY + 6,
    head: [['Ressource', 'Service', 'Région', 'Type', 'Qté', 'H/mois', 'Coût/mois']],
    body: tableData,
    theme: 'striped',
    headStyles: { 
      fillColor: [79, 70, 229],
      textColor: 255,
      fontStyle: 'bold'
    },
    styles: {
      fontSize: 9,
      cellPadding: 3
    },
    columnStyles: {
      0: { cellWidth: 40 },
      1: { cellWidth: 25 },
      2: { cellWidth: 35 },
      3: { cellWidth: 30 },
      4: { cellWidth: 15, halign: 'center' },
      5: { cellWidth: 20, halign: 'center' },
      6: { cellWidth: 25, halign: 'right', fontStyle: 'bold' }
    }
  });
  
  // Total
  const totalCost = resources.reduce((sum, r) => sum + parseFloat(r.monthly_cost || 0), 0);
  const finalY = doc.lastAutoTable.finalY + 10;
  
  doc.setFontSize(14);
  doc.setTextColor(79, 70, 229);
  doc.text(`Coût mensuel total: $${totalCost.toFixed(2)}`, 14, finalY);
  
  doc.setFontSize(12);
  doc.setTextColor(0, 0, 0);
  doc.text(`Coût annuel estimé: $${(totalCost * 12).toFixed(2)}`, 14, finalY + 8);
  
  // Pied de page
  const pageCount = doc.internal.getNumberOfPages();
  doc.setFontSize(8);
  doc.setTextColor(150, 150, 150);
  
  for (let i = 1; i <= pageCount; i++) {
    doc.setPage(i);
    doc.text(
      `Page ${i} sur ${pageCount} - Généré le ${new Date().toLocaleString('fr-FR')}`,
      14,
      doc.internal.pageSize.height - 10
    );
  }
  
  // Télécharger
  doc.save(`simulation-${simulation.name.replace(/\s+/g, '-')}-${Date.now()}.pdf`);
}

/**
 * Exporte une comparaison de 2 simulations en PDF
 */
export function exportComparisonToPDF(simulation1, resources1, simulation2, resources2) {
  const doc = new jsPDF();
  
  // En-tête
  doc.setFontSize(18);
  doc.setTextColor(79, 70, 229);
  doc.text('Comparaison de Simulations AWS', 14, 22);
  
  doc.setFontSize(11);
  doc.setTextColor(0, 0, 0);
  doc.text(`${simulation1.name} vs ${simulation2.name}`, 14, 30);
  doc.setFontSize(9);
  doc.text(`Date: ${new Date().toLocaleDateString('fr-FR')}`, 14, 36);
  
  // Ligne de séparation
  doc.setDrawColor(200, 200, 200);
  doc.line(14, 40, 196, 40);
  
  // Résumé des coûts
  const total1 = resources1.reduce((sum, r) => sum + parseFloat(r.monthly_cost || 0), 0);
  const total2 = resources2.reduce((sum, r) => sum + parseFloat(r.monthly_cost || 0), 0);
  const difference = total2 - total1;
  const percentageChange = total1 > 0 ? ((difference / total1) * 100).toFixed(1) : 0;
  
  doc.setFontSize(12);
  doc.setTextColor(0, 0, 0);
  doc.text('Résumé des coûts mensuels:', 14, 50);
  
  doc.setFontSize(10);
  doc.text(`${simulation1.name}: $${total1.toFixed(2)}`, 20, 58);
  doc.text(`${simulation2.name}: $${total2.toFixed(2)}`, 20, 64);
  
  doc.setFontSize(11);
  if (difference > 0) {
    doc.setTextColor(220, 38, 38); // Rouge
    doc.text(`Différence: +$${Math.abs(difference).toFixed(2)} (+${percentageChange}%)`, 20, 72);
  } else if (difference < 0) {
    doc.setTextColor(34, 197, 94); // Vert
    doc.text(`Économie: -$${Math.abs(difference).toFixed(2)} (${percentageChange}%)`, 20, 72);
  } else {
    doc.setTextColor(100, 100, 100);
    doc.text('Différence: $0.00 (0%)', 20, 72);
  }
  
  // Tableau simulation 1
  doc.setTextColor(0, 0, 0);
  doc.setFontSize(12);
  doc.text(simulation1.name, 14, 85);
  
  const tableData1 = resources1.map(r => [
    r.resource_name || 'N/A',
    r.service?.name || 'N/A',
    r.instance_type?.name || 'N/A',
    `$${parseFloat(r.monthly_cost || 0).toFixed(2)}`
  ]);
  
  doc.autoTable({
    startY: 88,
    head: [['Ressource', 'Service', 'Type', 'Coût/mois']],
    body: tableData1,
    theme: 'grid',
    headStyles: { fillColor: [79, 70, 229] },
    styles: { fontSize: 8 }
  });
  
  // Tableau simulation 2
  const startY2 = doc.lastAutoTable.finalY + 15;
  doc.setFontSize(12);
  doc.text(simulation2.name, 14, startY2);
  
  const tableData2 = resources2.map(r => [
    r.resource_name || 'N/A',
    r.service?.name || 'N/A',
    r.instance_type?.name || 'N/A',
    `$${parseFloat(r.monthly_cost || 0).toFixed(2)}`
  ]);
  
  doc.autoTable({
    startY: startY2 + 3,
    head: [['Ressource', 'Service', 'Type', 'Coût/mois']],
    body: tableData2,
    theme: 'grid',
    headStyles: { fillColor: [79, 70, 229] },
    styles: { fontSize: 8 }
  });
  
  // Pied de page
  const pageCount = doc.internal.getNumberOfPages();
  doc.setFontSize(8);
  doc.setTextColor(150, 150, 150);
  
  for (let i = 1; i <= pageCount; i++) {
    doc.setPage(i);
    doc.text(
      `Page ${i} sur ${pageCount}`,
      14,
      doc.internal.pageSize.height - 10
    );
  }
  
  doc.save(`comparaison-${Date.now()}.pdf`);
}

/**
 * Exporte une comparaison en CSV
 */
export function exportComparisonToCSV(simulation1, resources1, simulation2, resources2) {
  const csvData = [];
  
  // En-tête
  csvData.push({
    'Simulation': simulation1.name,
    'Ressource': '',
    'Service': '',
    'Type': '',
    'Coût mensuel': ''
  });
  
  // Resources simulation 1
  resources1.forEach(r => {
    csvData.push({
      'Simulation': '',
      'Ressource': r.resource_name || 'N/A',
      'Service': r.service?.name || 'N/A',
      'Type': r.instance_type?.name || 'N/A',
      'Coût mensuel': `$${parseFloat(r.monthly_cost || 0).toFixed(2)}`
    });
  });
  
  const total1 = resources1.reduce((sum, r) => sum + parseFloat(r.monthly_cost || 0), 0);
  csvData.push({
    'Simulation': '',
    'Ressource': 'TOTAL',
    'Service': '',
    'Type': '',
    'Coût mensuel': `$${total1.toFixed(2)}`
  });
  
  // Ligne vide
  csvData.push({
    'Simulation': '',
    'Ressource': '',
    'Service': '',
    'Type': '',
    'Coût mensuel': ''
  });
  
  // Simulation 2
  csvData.push({
    'Simulation': simulation2.name,
    'Ressource': '',
    'Service': '',
    'Type': '',
    'Coût mensuel': ''
  });
  
  resources2.forEach(r => {
    csvData.push({
      'Simulation': '',
      'Ressource': r.resource_name || 'N/A',
      'Service': r.service?.name || 'N/A',
      'Type': r.instance_type?.name || 'N/A',
      'Coût mensuel': `$${parseFloat(r.monthly_cost || 0).toFixed(2)}`
    });
  });
  
  const total2 = resources2.reduce((sum, r) => sum + parseFloat(r.monthly_cost || 0), 0);
  csvData.push({
    'Simulation': '',
    'Ressource': 'TOTAL',
    'Service': '',
    'Type': '',
    'Coût mensuel': `$${total2.toFixed(2)}`
  });
  
  // Différence
  const difference = total2 - total1;
  csvData.push({
    'Simulation': '',
    'Ressource': '',
    'Service': '',
    'Type': '',
    'Coût mensuel': ''
  });
  csvData.push({
    'Simulation': 'DIFFÉRENCE',
    'Ressource': '',
    'Service': '',
    'Type': '',
    'Coût mensuel': `$${difference.toFixed(2)}`
  });
  
  const csv = Papa.unparse(csvData);
  
  const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
  const link = document.createElement('a');
  const url = URL.createObjectURL(blob);
  
  link.setAttribute('href', url);
  link.setAttribute('download', `comparaison-${Date.now()}.csv`);
  link.style.visibility = 'hidden';
  
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
}