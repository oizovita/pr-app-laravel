<?php

namespace Domain\Auth\DTO;

use Spatie\DataTransferObject\DataTransferObject;

class LoginDto extends DataTransferObject
{
    public string $email;
    public string $password;
}
