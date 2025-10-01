import { useState } from "react";
import { useForm } from "react-hook-form";
import axios from "axios";

const FormComponent = () => {
  const { register, handleSubmit, watch } = useForm();
  const [selectedEC2, setSelectedEC2] = useState("");
  const [loading, setLoading] = useState(false);

  const selectedService = watch("service");

  const onSubmit = async (data) => {
    try {
      setLoading(true);
      const url = `https://pricing.${data.region}.amazonaws.com/offers/v1.0/aws/AmazonEC2/current/${data.region}/index.json`;
      const response = await axios.get(url);
      console.log("AWS Pricing Data:", response.data);
      setLoading(false);
    } catch (error) {
      console.error(error);
      setLoading(false);
    }
  };

  const regions = [
    { value: "us-east-1", label: "US East (N. Virginia)" },
    { value: "us-west-1", label: "US West (N. California)" },
    { value: "eu-west-1", label: "EU (Ireland)" },
    { value: "eu-central-1", label: "EU (Frankfurt)" },
    { value: "eu-west-3", label: "EU (Paris)" },
    { value: "eu-west-2", label: "EU (London)" },
    { value: "ap-south-1", label: "AP South (Mumbai)" },
    { value: "ap-southeast-1", label: "AP Southeast (Singapore)" },
    { value: "ap-southeast-2", label: "AP Southeast (Sydney)" },
    { value: "ap-northeast-1", label: "AP Northeast (Tokyo)" },
    { value: "ap-northeast-2", label: "AP Northeast (Seoul)" },
    { value: "ap-northeast-3", label: "AP Northeast (Osaka)" },
    { value: "ca-central-1", label: "Canada (Central)" },
    { value: "sa-east-1", label: "South America (São Paulo)" },
  ];

  return (
    <form
      onSubmit={handleSubmit(onSubmit)}
      className="max-w-lg mx-auto bg-white p-6 rounded-2xl shadow-lg space-y-6"
    >
      <h2 className="text-2xl font-bold text-center text-indigo-600 mb-4">
        Comparateur AWS
      </h2>

      {/* Service */}
      <div>
        <label
          htmlFor="service"
          className="block text-gray-700 font-medium mb-1"
        >
          Service
        </label>
        <select
          id="service"
          {...register("service")}
          className="block w-full p-2 border border-gray-300 rounded-md shadow-sm focus:ring focus:ring-indigo-300"
        >
          <option value="EC2">EC2 (Serveurs virtuels)</option>
          <option value="RDS">RDS (Bases de données)</option>
          <option value="S3">S3 (Stockage fichiers)</option>
          <option value="Lambda">Lambda (Serverless)</option>
          <option value="ECS/EKS">ECS / EKS (Conteneurs)</option>
        </select>
      </div>

      {/* Region */}
      <div>
        <label
          htmlFor="region"
          className="block text-gray-700 font-medium mb-1"
        >
          Région
        </label>
        <select
          id="region"
          {...register("region")}
          className="block w-full p-2 border border-gray-300 rounded-md shadow-sm focus:ring focus:ring-indigo-300"
        >
          {regions.map((region) => (
            <option key={region.value} value={region.value}>
              {region.label}
            </option>
          ))}
        </select>
      </div>

      {/* EC2 Type - only show if EC2 is selected */}
      {selectedService === "EC2" && (
        <div>
          <label
            htmlFor="ec2_type"
            className="block text-gray-700 font-medium mb-1"
          >
            Type d’instance EC2
          </label>
          <select
            id="ec2_type"
            value={selectedEC2}
            onChange={(e) => setSelectedEC2(e.target.value)}
            className="block w-full p-2 rounded-md border border-gray-300 shadow-sm focus:ring focus:ring-indigo-300"
          >
            <option value="">-- Sélectionner --</option>
            <option value="t">🟢 Basique / Test (usage léger)</option>
            <option value="m">⚖️ Standard (usage général)</option>
            <option value="c">🚀 Puissance CPU (calcul intensif)</option>
            <option value="r">🧠 Mémoire++ (bases de données)</option>
            <option value="g">🎮 Graphiques & IA (GPU)</option>
            <option value="i">💾 Disque ultra-rapide (stockage local)</option>
            <option value="hpc">⚡ Super réseau (HPC, Big Data)</option>
          </select>

          {selectedEC2 && (
            <div className="mt-3 p-3 rounded-lg bg-gray-100 shadow-inner">
              <p className="font-medium text-gray-800">✅ Vous avez choisi :</p>
              <p className="text-indigo-600">
                {
                  {
                    t: "Basique / Test – pour petits sites ou environnements de test",
                    m: "Standard – équilibre CPU/mémoire pour applications classiques",
                    c: "Puissance CPU – calculs lourds, rendu, analytics",
                    r: "Mémoire++ – bases de données, gros caches, in-memory",
                    g: "Graphiques & IA – machine learning, rendu vidéo/3D",
                    i: "Disque ultra-rapide – stockage local intensif",
                    hpc: "Super réseau – haute performance, Big Data, HPC",
                  }[selectedEC2]
                }
              </p>
            </div>
          )}
        </div>
      )}

      {/* Submit */}
      <div className="text-center">
        <button
          type="submit"
          disabled={loading}
          className="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-6 rounded-xl shadow-md transition disabled:opacity-50"
        >
          {loading ? "Chargement..." : "Comparer"}
        </button>
      </div>
    </form>
  );
};

export default FormComponent;
