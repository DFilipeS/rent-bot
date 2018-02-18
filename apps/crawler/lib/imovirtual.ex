defmodule Crawler.Imovirtual do
  def import(page \\ 1) do
    url = "https://www.imovirtual.com/arrendar/apartamento/porto/?search%5Bfilter_float_price%3Ato%5D=600&search%5Bdescription%5D=1&search%5Border%5D=created_at_first%3Adesc&page=#{page}"

    url
    |> get_page_html()
    |> get_dom_elements()
    |> extract_metadata()
  end

  defp get_page_html(url) do
    %HTTPoison.Response{body: body} = HTTPoison.get!(url, [], follow_redirect: true)
    body
  end

  defp get_dom_elements(body) do
    Floki.find(body, "div.col-md-content > article.offer-item")
  end

  defp extract_metadata(elements) do
    Enum.map(elements, fn {"article", attrs, content} ->
      %{
        title: title(content),
        url: url(attrs),
        price: price(content),
        image: image(content),
        provider: "Imovirtual"
      }
    end)
  end

  defp title(html) do
    [{"span", _attrs, [title]}] = Floki.find(html, "div.offer-item-details > header > h3 span.offer-item-title")
    [{"p", _attrs, [subtitle]}] = Floki.find(html, "div.offer-item-details > header > p")
    "#{String.trim(title)} - #{String.trim(subtitle)}"
  end

  defp url(attrs) do
    {"data-url", url} = List.keyfind(attrs, "data-url", 0)
    url
  end

  defp price(html) do
    [{"li", _attrs, [price]}] = Floki.find(html, "div.offer-item-details li.offer-item-price")
    Regex.replace(~r/(\s)+/, String.trim(price), " ")
  end

  defp image(html) do
    [{"figure", attrs, _content}] = Floki.find(html, "figure.offer-item-image")
    {"data-quick-gallery", images} = List.keyfind(attrs, "data-quick-gallery", 0)
    images = Poison.decode!(images)
    cond do
      length(images) > 0 ->
        %{"photo" => image} = Enum.at(images, 0)
        image
      true ->
        ""
    end
  end
end
