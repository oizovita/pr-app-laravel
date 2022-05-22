<?php
declare(strict_types=1);

namespace Domain\Auth\DTO;

use Spatie\DataTransferObject\DataTransferObject;

class RegisterDTO extends DataTransferObject
{
    public string $email;

    public string $password;

    public string $firstname;

    public string $lastname;
}
