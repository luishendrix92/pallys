defmodule Pallys.Palbot do
  alias Pallys.Helpers

  @ranks (for division <- ["Bronze", "Silver", "Gold", "Platinum", "Diamond"],
              tier <- 5..1, do: "#{division} #{tier}") ++ ["Masters", "Grandmaster"]

  def player_rank(%{"Name" => name, "Wins" => wins, "Losses" => losses, "Level" => level, "RankedConquest" => r}) do
    player = "#{name} (Lv.#{level})"

    case [wins, losses, r["Tier"], r["Wins"], r["Losses"]] do
      [0, 0, _, _, _] -> "#{player} hasn't played any match yet!"
      [w, l, 0, 0, 0] -> "#{player} is unranked this season. General win rate of #{win_ratio(w, l)}% (#{w}-#{l})"
      [w, l, 0, p_w, p_l] -> "#{player} is #{p_w}-#{p_l} in placements. General win rate of #{win_ratio(w, l)}% (#{w}-#{l})"
      [w, l, 27, r_w, r_l] -> "#{player} is the ##{r["Rank"]} #{Enum.at(@ranks, 26)}. Win rate: Ranked #{win_ratio(r_w, r_l)}% (#{r_w}-#{r_l}) & General #{win_ratio(w, l)}% (#{w}-#{l})"
      [w, l, t, r_w, r_l] -> "#{player} is in #{Enum.at(@ranks, t - 1)}. Win rate: Ranked #{win_ratio(r_w, r_l)}% (#{r_w}-#{r_l}) & General #{win_ratio(w, l)}% (#{w}-#{l})"
    end
  end

  def regions([%{"playerName" => player} | _] = history) do
    sorted_regions = Helpers.count_by(history, &Map.get(&1, "Region"))

    case sorted_regions do
      [{region, n_matches}] -> "#{player} has only played in #{region} for the last #{n_matches} matches."
      _ -> "#{player} has recently played in: " <>
        (sorted_regions
          |> Stream.map(fn {r, n} -> "#{r} (#{n} matches)" end)
          |> Enum.join(", "))
    end
  end

  def mains([%{"playerName" => player} | _] = history) do
    sorted_champs = Helpers.count_by(history, &Map.get(&1, "Champion"))

    case sorted_champs do
      [{champ, n_matches}] -> "#{player} recently one-tricked #{champ} for #{n_matches} matches..."
      [{c1, n1}, {c2, n2}] -> "#{player} has only played #{c1} and #{c2} in their last #{n1 + n2} matches."
      [{c_1, n_1}, {c_2, n_2}, {c_3, n_3} | _] ->
        "#{player} has played mostly #{c_1} (#{n_1}), #{c_2} (#{n_2}), and #{c_3} (#{n_3}) in recent matches."
    end
  end

  defp win_ratio(0, 0), do: 0
  defp win_ratio(w, l), do: trunc(w / (w + l) * 100)
end
