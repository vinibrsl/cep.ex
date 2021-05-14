<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/BRA_orthographic.svg/270px-BRA_orthographic.svg.png" align="right" />

# cep.ex
> Brazilian zipcode lookup (CEP) library for Elixir.

## Installing

The package can be installed by adding `cepex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cepex, "~> 0.1.0"}
  ]
end

# => Rock on! 🚀
```

## Usage

```elixir
# With formatted zipcode strings :)
iex> Cepex.lookup("80010-180")
{:ok, %Cepex.Address{
  address: "Rua Barão do Rio Branco",
  cep: "80010180",
  city: "Curitiba",
  complement: "",
  http_response: %Cepex.HTTP.Response{},
  neighborhood: "Centro",
  state: "PR"
}}

# With zipcode integers :)
iex> Cepex.lookup(80010180)
{:ok, %Cepex.Address{
  address: "Rua Barão do Rio Branco",
  cep: "80010180",
  city: "Curitiba",
  complement: "",
  http_response: %Cepex.HTTP.Response{},
  neighborhood: "Centro",
  state: "PR"
}}

# With unformatted zipcode strings :)
iex> Cepex.lookup("80210130")
{:ok, %Cepex.Address{
  address: "Rua Barão do Rio Branco",
  cep: "80010180",
  city: "Curitiba",
  complement: "",
  http_response: %Cepex.HTTP.Response{},
  neighborhood: "Centro",
  state: "PR"
}}
```

## Contributing

1. Create a fork (https://github.com/vnbrs/cep.ex/fork)
2. Create a branch (git checkout -b my-new-feature)
3. Make a commit  (git commit -am 'Add some feature')
4. Push your code (git push origin my-new-feature)
5. Create a Pull Request
6. Thanks! 🤙
