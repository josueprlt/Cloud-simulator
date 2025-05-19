<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use ApiPlatform\Metadata\GetCollection;
use ApiPlatform\Metadata\Post;
use ApiPlatform\Metadata\Get;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Serializer\Attribute\Groups;
use Symfony\Component\Serializer\Attribute\MaxDepth;

#[ORM\Entity]
#[ApiResource(
    operations: [
        new GetCollection(),
        new Post(),
        new Get()
    ],
    normalizationContext: ['groups' => ['trip:read'], 'enable_max_depth' => true]
    )]
class Trip
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    #[Groups(['trip', 'trip:read'])]
    private ?int $id = null;

    #[ORM\Column(types::STRING, length: 255)]
    #[Groups(['trip', 'trip:read'])]
    private string $title;

    #[ORM\Column(type: Types::TEXT)]
    #[Groups(['trip'])]
    private string $description;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    #[Groups(['trip'])]
    private \DateTimeInterface $startAt;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    #[Groups(['trip'])]
    private \DateTimeInterface $endAt;

    #[ORM\Column(type: Types::STRING)]
    #[Groups(['trip', 'trip:read'])]
    private string $thumbnail = 'https://i.postimg.cc/T1Vjc2h0/trip.jpg';

    #[ORM\Column(type: Types::BOOLEAN)]
    #[Groups(['trip', 'trip:read'])]
    private bool $isArchive = false;

    /**
     * @var Collection<int, User>
     */
    #[ORM\ManyToMany(targetEntity: User::class, inversedBy: 'trips')]
    #[ORM\JoinTable(name: 'user_trip')]
    #[Groups(['trip', 'trip:read'])]
    #[MaxDepth(1)]
    private Collection $users;

    public function __construct()
    {
        $this->users = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): static
    {
        $this->title = $title;

        return $this;
    }

    public function getStartAt(): ?\DateTimeInterface
    {
        return $this->startAt;
    }

    public function setStartAt(\DateTimeInterface $startAt): static
    {
        $this->startAt = $startAt;

        return $this;
    }

    public function getEndAt(): ?\DateTimeInterface
    {
        return $this->endAt;
    }

    public function setEndAt(\DateTimeInterface $endAt): static
    {
        $this->endAt = $endAt;

        return $this;
    }

    /**
     * Get the value of description
     */ 
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set the value of description
     *
     * @return  self
     */ 
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Get the value of thumbnail
     */ 
    public function getThumbnail()
    {
        return $this->thumbnail;
    }

    /**
     * Set the value of thumbnail
     *
     * @return  self
     */ 
    public function setThumbnail($thumbnail)
    {
        $this->thumbnail = $thumbnail;

        return $this;
    }

    /**
     * Get the value of isArchive
     */ 
    public function getIsArchive()
    {
        return $this->isArchive;
    }

    /**
     * Set the value of isArchive
     *
     * @return  self
     */ 
    public function setIsArchive($isArchive)
    {
        $this->isArchive = $isArchive;

        return $this;
    }

     /**
     * @return Collection<int, User>
     */
    public function getUsers(): Collection
    {
        return $this->users;
    }

    public function addUser(User $user): self
    {
        if (!$this->users->contains($user)) {
            $this->users[] = $user;
            $user->addTrip($this);
        }

        return $this;
    }

    public function removeUser(User $user): self
    {
        if ($this->users->removeElement($user)) {
            $user->removeTrip($this);
        }

        return $this;
    }
}
