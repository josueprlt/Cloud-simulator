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
    public static function create(Expense $expense, ExpenseType $type, array $data, $entityManager): Expense
    {
        $expense->setTitle($data['title']);
        $expense->setCost($data['cost']);
        $expense->setPayed($data['is_payed']);
        $expense->setPicture($data['picture']);
        $expense->setType($type);
        // $expense->setAddressId();
        // $expense->setVoyageId();

        match ($type) {
            ExpenseType::ACCOMODATION => self::createAccomodation($data, $expense, $entityManager),
            ExpenseType::ACTIVITY => self::createActivity($data, $expense, $entityManager),
            ExpenseType::OTHER => null
        };

        return $expense;
    }

    /**
     * @throws \DateMalformedStringException
     */
    private static function createAccomodation(array $data, Expense $expense, $entityManager): void
    {
        $accomodation = $expense->getAccomodation() ?? new Accomodation();

        $accomodationType = AccomodationType::fromString($data['accomodation_type']);
        if($accomodationType === null) {
            throw new \InvalidArgumentException('Type d\'hébergement invalide');
        }

        $checkIn =new \DateTimeImmutable($data['check_in']);
        $checkOut = new \DateTimeImmutable($data['check_out']);

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
        $activity = $expense->getActivity() ?? new Activity();

        $startAt =new \DateTimeImmutable($data['start_at']);
        $endAt = new \DateTimeImmutable($data['end_at']);

        $activity->setStartAt($startAt);
        $activity->setEndAt($endAt);
        $activity->setDescription($data['description']);
        $activity->setLink($data['link'] ?? null);
        $activity->setExpenseId($expense);

        $entityManager->persist($activity);
        $entityManager->flush();
    }
}
