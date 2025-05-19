<?php

namespace App\Controller;

use App\Entity\Expense;
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

    /**
     * @throws \DateMalformedStringException
     */
    public function __invoke(Request $request): Response
    {
        $dataTable = json_decode($request->getContent(), true);
        $expense = null;
        $successMessage = null;

        if (!isset($dataTable['type']) || !isset($dataTable['data'])) {
            return new JsonResponse(['error' => 'Invalid data, dataTable pas ienb'], 400);
       }
       $type = $dataTable['type'];
       $data = $dataTable['data'];
       $expenseType = ExpenseType::fromString($type);

       if($expenseType === null) {
           return new JsonResponse(['error' => 'Invalid data, expenseType = null'], 400);
       }

       if ($request->getMethod() === Request::METHOD_POST) {
            $expense = new Expense();
            $successMessage = 'Expense created';
        } elseif ($request->getMethod() === Request::METHOD_PUT) {
            $expenses = $this->entityManager->getRepository(Expense::class);
            $expense = $expenses->find((int)($request->attributes->get('id')));
            $successMessage = 'Expense updated';
        }

        $createdExpense = ExpenseFactory::create($expense, $expenseType, $data, $this->entityManager);
        $this->entityManager->persist($expense);
        $this->entityManager->flush();
        return new JsonResponse(['message' => $successMessage, 'id' => $createdExpense->getId(), 'type' => $type], 201);

}
}
