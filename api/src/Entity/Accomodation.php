<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use ApiPlatform\Metadata\Delete;
use ApiPlatform\Metadata\Get;
use ApiPlatform\Metadata\GetCollection;
use App\Enum\AccomodationType;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Attribute\Groups;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity]
#[ApiResource(
    operations: [
        new Get(),
        new GetCollection(),
        new Delete()
    ],
    normalizationContext: [
        'groups' => ['accomodation:read'],
    ],
)]
class Accomodation
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private int $id;

    #[ORM\Column(length: 255)]
    #[Assert\NotBlank(message: "Le nom ne peut pas être vide.")]
    #[Groups(['accomodation:read'])]
    private string $name;

    #[ORM\Column(enumType: AccomodationType::class)]
    #[Assert\NotNull(message: "Le type d'hébergement ne peut pas être nul.")]
    #[Groups(['accomodation:read'])]
    private AccomodationType $type;

    #[ORM\Column]
    #[Assert\NotBlank(message: "La date du check-in ne peut pas être vide.")]
    #[Groups(['accomodation:read'])]
    private \DateTimeImmutable $checkIn;

    #[ORM\Column]
    #[Assert\NotBlank(message: "La date du check-out ne peut pas être vide.")]
    #[Groups(['accomodation:read'])]
    private \DateTimeImmutable $checkOut;

    #[ORM\Column(options: ['default' => false])]
    #[Groups(['accomodation:read'])]
    private bool $breakfast = false;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    #[Groups(['accomodation:read'])]
    private ?string $schedule = null;

    #[ORM\OneToOne(inversedBy: 'accomodation', cascade: ['persist', 'remove'])]
    #[ORM\JoinColumn(nullable: false)]
    #[Groups(['accomodation:read'])]
    private Expense $expenseId;

    public function getId(): int
    {
        return $this->id;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function setName(string $name): static
    {
        $this->name = $name;

        return $this;
    }

    public function getType(): AccomodationType
    {
        return $this->type;
    }

    public function setType(AccomodationType $type): static
    {
        $this->type = $type;

        return $this;
    }

    public function getCheckIn(): \DateTimeImmutable
    {
        return $this->checkIn;
    }

    public function setCheckIn(\DateTimeImmutable $checkIn): static
    {
        $this->checkIn = $checkIn;

        return $this;
    }

    public function getCheckOut(): \DateTimeImmutable
    {
        return $this->checkOut;
    }

    public function setCheckOut(\DateTimeImmutable $checkOut): static
    {
        $this->checkOut = $checkOut;

        return $this;
    }

    public function isBreakfast(): ?bool
    {
        return $this->breakfast;
    }

    public function setBreakfast(bool $breakfast): static
    {
        $this->breakfast = $breakfast;

        return $this;
    }

    public function getSchedule(): ?string
    {
        return $this->schedule;
    }

    public function setSchedule(?string $schedule): static
    {
        $this->schedule = $schedule;

        return $this;
    }

    public function getExpenseId(): ?Expense
    {
        return $this->expenseId;
    }

    public function setExpenseId(Expense $expenseId): static
    {
        $this->expenseId = $expenseId;

        return $this;
    }
}
