###
#    Copyright (c) ppy Pty Ltd <contact@ppy.sh>.
#
#    This file is part of osu!web. osu!web is distributed with the hope of
#    attracting more community contributions to the core ecosystem of osu!.
#
#    osu!web is free software: you can redistribute it and/or modify
#    it under the terms of the Affero GNU General Public License version 3
#    as published by the Free Software Foundation.
#
#    osu!web is distributed WITHOUT ANY WARRANTY; without even the implied
#    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with osu!web.  If not, see <http://www.gnu.org/licenses/>.
###

{div, a, span, h1, h2} = ReactDOMFactories
el = React.createElement

class MPHistory.GameHeader extends React.Component
  timeFormat: 'LT'

  render: ->
    timeStart = moment(@props.game.start_time).format @timeFormat
    timeEnd = moment(@props.game.end_time).format @timeFormat

    timeString = "#{timeStart} "

    title = @props.beatmapset.title
    title += " [#{@props.beatmap.version}]" if @props.beatmap.version

    if @props.game.end_time
      timeString += "- #{timeEnd}"
    else
      timeString += osu.trans 'multiplayer.match.in-progress'

    a
      className: 'mp-history-game__header'
      href: (laroute.route 'beatmaps.show', beatmap: @props.beatmap.id) if @props.beatmap.id
      style:
        backgroundImage: osu.urlPresence(@props.beatmapset.covers.cover)

      div
        className: 'mp-history-game__header-overlay'

      div className: 'mp-history-game__stats-box',
        span className: 'mp-history-game__stat', timeString
        span className: 'mp-history-game__stat', osu.trans "beatmaps.mode.#{@props.game.mode}"
        span className: 'mp-history-game__stat', osu.trans "multiplayer.game.scoring-type.#{@props.game.scoring_type}"

      div className: 'mp-history-game__metadata-box',
        h1 className: 'mp-history-game__metadata mp-history-game__metadata--title',
          title
        h2 className: 'mp-history-game__metadata mp-history-game__metadata--artist', @props.beatmapset.artist

      div className: 'mp-history-game__mods-box',
        el Mods,
          mods: @props.game.mods
          modifiers: ['large', 'reversed']

      div
        className: 'mp-history-game__team-type'
        title: osu.trans "multiplayer.match.team-types.#{@props.game.team_type}"
        style:
          backgroundImage: "url(/images/badges/team-types/#{@props.game.team_type}.svg)"
