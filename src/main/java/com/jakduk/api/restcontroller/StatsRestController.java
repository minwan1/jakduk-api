package com.jakduk.api.restcontroller;

import com.jakduk.api.common.JakdukConst;
import com.jakduk.api.common.util.JakdukUtils;
import com.jakduk.api.model.db.AttendanceClub;
import com.jakduk.api.model.db.AttendanceLeague;
import com.jakduk.api.model.db.Competition;
import com.jakduk.api.model.etc.SupporterCount;
import com.jakduk.api.restcontroller.vo.stats.SupportersDataResponse;

import com.jakduk.api.service.CompetitionService;
import com.jakduk.api.service.StatsService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * @author pyohwan
 * 16. 3. 20 오후 11:25
 */

@Slf4j
@Api(tags = "Stats", description = "통계 API")
@RestController
@RequestMapping("/api/stats")
public class StatsRestController {

    @Autowired
    private StatsService statsService;

    @Autowired
    private CompetitionService competitionService;

    @ApiOperation(value = "대회별 관중수 목록")
    @RequestMapping(value = "/league/attendances", method = RequestMethod.GET)
    public List<AttendanceLeague> getLeagueAttendances(@RequestParam(required = false) String competitionId,
                                                       @RequestParam(required = false) String competitionCode) {

        Competition competition = null;
        List<AttendanceLeague> leagueAttendances;

        Sort sort = new Sort(Sort.Direction.ASC, Arrays.asList("_id"));

        if (Objects.nonNull(competitionId)) {
            competition = competitionService.findOneById(competitionId);
        } else if (Objects.nonNull(competitionCode)) {
            competition = competitionService.findCompetitionByCode(competitionCode);
        }

        if (Objects.isNull(competition)) {
            leagueAttendances = statsService.findLeagueAttendances(sort);
        } else {
            leagueAttendances = statsService.findLeagueAttendances(competition, sort);
        }

        return leagueAttendances;
    }

    @ApiOperation(value = "구단별 관중수 목록")
    @RequestMapping(value = "/attendance/club/{clubOrigin}", method = RequestMethod.GET)
    public List<AttendanceClub> getAttendancesClubs(@PathVariable String clubOrigin) {

        return statsService.getAttendanceClub(clubOrigin);
    }

    @ApiOperation(value = "연도별 관중수 목록")
    @RequestMapping(value = "/attendance/season/{season}", method = RequestMethod.GET)
    public List<AttendanceClub> getAttendanceSeason(@PathVariable Integer season,
                                                    @RequestParam(required = false, defaultValue = JakdukConst.K_LEAGUE_ABBREVIATION) String league){

        return statsService.getAttendancesSeason(season, league);
    }

    @RequestMapping(value = "/supporters", method = RequestMethod.GET)
    public SupportersDataResponse dataSupporter() {

        String language = JakdukUtils.getLanguageCode();
        Map<String, Object> data = statsService.getSupportersData(language);

        return SupportersDataResponse.builder()
          .supporters((List<SupporterCount>) data.get("supporters"))
          .supportersTotal((Integer) data.get("supportersTotal"))
          .usersTotal((Integer) data.get("usersTotal"))
          .build();
    }
}
