<?php

namespace App\Factory;

use App\Entity\Accomodation;
use App\Entity\Expense;
use App\Entity\Activity;
use App\Enum\AccomodationType;
use App\Enum\ExpenseType;

class ExpenseFactory
{
    /**
     * @throws \DateMalformedStringException
     */
    public static function create(ExpenseType $type, array $data, $entityManager): Expense
    {
        $expense = new Expense();
        $expense->setTitle($data['title']);
        $expense->setCost($data['cost']);
        $expense->isPayed($data['is_payed']);
        $expense->setPicture($data['picture']);
        $expense->setType($type);
        // $expense->setAddressId();
        // $expense->setVoyageId();

        match ($type) {
            ExpenseType::ACCOMODATION => self::createAccomodation($data, $expense, $entityManager),
            ExpenseType::ACTIVITY => self::createActivity($data, $expense, $entityManager),
        };

        return $expense;
    }

    /**
     * @throws \DateMalformedStringException
     */
    private static function createAccomodation(array $data, Expense $expense, $entityManager): void
    {
        $accomodationType = AccomodationType::fromString($data['accomodation_type']);
        if($accomodationType === null) {
            throw new \InvalidArgumentException('Type d\'hébergement invalide');
        }

        $checkIn =new \DateTimeImmutable($data['check_in']);
        $checkOut = new \DateTimeImmutable($data['check_out']);

        $accomodation = new Accomodation();
        $accomodation->setName($data['name']);
        $accomodation->setType($accomodationType);
        $accomodation->setCheckIn($checkIn);
        $accomodation->setCheckOut($checkOut);
        $accomodation->setBreakfast($data['breakfast']);
        $accomodation->setSchedule($data['schedule'] ?? null);
        $accomodation->setExpenseId($expense);

        $entityManager->persist($accomodation);
        $entityManager->flush();
    }

    private static function createActivity(array $data, Expense $expense, $entityManager): void
    {
        $activity = new Activity();
        $activity->setStartAt($data['start_at']);
        $activity->setEndAt($data['end_at']);
        $activity->setDescription($data['description']);
        $activity->setLink($data['link'] ?? null);
        $activity->setExpenseId($expense);

        $entityManager->persist($activity);
        $entityManager->flush();
    }
}
