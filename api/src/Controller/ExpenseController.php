<?php

namespace App\Controller;

use App\Enum\ExpenseType;
use App\Factory\ExpenseFactory;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Doctrine\ORM\EntityManagerInterface;


class ExpenseController extends AbstractController
{
    public function __construct(private readonly EntityManagerInterface $entityManager)
    {
    }

    #[Route('/api/expense', name: 'app_expense', methods: ['POST'])]
    public function __invoke(Request $request): Response
    {
        $dataTable = json_decode($request->getContent(), true);

        if (!isset($dataTable['type']) || !isset($dataTable['data'])) {
            return new JsonResponse(['error' => 'Invalid data'], 400);
       }
       $type = $dataTable['type'];
       $data = $dataTable['data'];

       $expenseType = ExpenseType::fromString($type);

       if($expenseType === null) {
           return new JsonResponse(['error' => 'Invalid data'], 400);
       }

        $expense = ExpenseFactory::create($expenseType, $data, $this->entityManager);
        $this->entityManager->persist($expense);
        $this->entityManager->flush();

        return new JsonResponse(['message' => 'Expense created', 'id' => $expense->getId()], 201);
    }
}
