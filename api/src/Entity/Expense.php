<?php

namespace App\Entity;

use ApiPlatform\Metadata\Delete;
use ApiPlatform\Metadata\Get;
use ApiPlatform\Metadata\GetCollection;
use ApiPlatform\Metadata\Put;
use App\Controller\ExpenseController;
use ApiPlatform\Metadata\ApiResource;
use ApiPlatform\Metadata\Post;
use App\Enum\ExpenseType;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Attribute\Groups;
use Symfony\Component\Validator\Constraints as Assert;

#[ORM\Entity]
#[ApiResource(
    operations: [
        new Get(),
        new GetCollection(),
        new Post(
            controller: ExpenseController::class,
        ),
        new Put(
            controller: ExpenseController::class,
        ),
        new Delete()
    ],
    normalizationContext: [
        'groups' => ['expense:read'],
    ],
)]
class Expense
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private readonly int $id;

    #[ORM\Column(length: 255)]
    #[Assert\NotBlank(message: "Le nom ne peut pas être vide.")]
    #[Groups(['expense:read', 'accomodation:read', 'activity:read'])]
    private string $title;

    #[ORM\Column]
    #[Assert\NotBlank(message: "Le coût ne peut pas être vide.")]
    #[Groups(['expense:read', 'accomodation:read', 'activity:read'])]
    private ?int $cost = null;

    #[ORM\Column(options: ['default' => false])]
    #[Groups(['expense:read', 'accomodation:read', 'activity:read'])]
    private bool $isPayed = false;

    #[ORM\Column(enumType: ExpenseType::class)]
    #[Assert\NotBlank(message: "Vous devez choisir un type de dépense.")]
    #[Groups(['expense:read', 'accomodation:read', 'activity:read'])]
    private ExpenseType $type;

    #[ORM\Column(length: 255)]
    #[Assert\NotBlank(message: "L'image ne peut pas être vide.")]
    #[Groups(['expense:read', 'accomodation:read', 'activity:read'])]
    private string $picture;

    #[ORM\OneToOne(mappedBy: 'expenseId', cascade: ['persist', 'remove'])]
    #[Groups(['expense:read'])]
    private ?Activity $activity = null;

    #[ORM\OneToOne(mappedBy: 'expenseId', cascade: ['persist', 'remove'])]
    #[Groups(['expense:read'])]
    private ?Accomodation $accomodation = null;

    public function getId(): int
    {
        return $this->id;
    }

    public function getTitle(): string
    {
        return $this->title;
    }

    public function setTitle(string $title): static
    {
        $this->title = $title;

        return $this;
    }

    public function getCost(): int
    {
        return $this->cost;
    }

    public function setCost(int $cost): static
    {
        $this->cost = $cost;

        return $this;
    }

    public function isPayed(): bool
    {
        return $this->isPayed;
    }

    public function setPayed(bool $isPayed): static
    {
        $this->isPayed = $isPayed;

        return $this;
    }

    public function getType(): ?ExpenseType
    {
        return $this->type;
    }

    public function setType(ExpenseType $type): static
    {
        $this->type = $type;

        return $this;
    }

    public function getPicture(): ?string
    {
        return $this->picture;
    }

    public function setPicture(string $picture): static
    {
        $this->picture = $picture;

        return $this;
    }

    public function getActivity(): ?Activity
    {
        return $this->activity;
    }

    public function setActivity(Activity $activity): static
    {
        // set the owning side of the relation if necessary
        if ($activity->getExpenseId() !== $this) {
            $activity->setExpenseId($this);
        }

        $this->activity = $activity;

        return $this;
    }

    public function getAccomodation(): ?Accomodation
    {
        return $this->accomodation;
    }

    public function setAccomodation(Accomodation $accomodation): static
    {
        // set the owning side of the relation if necessary
        if ($accomodation->getExpenseId() !== $this) {
            $accomodation->setExpenseId($this);
        }

        $this->accomodation = $accomodation;

        return $this;
    }
}
