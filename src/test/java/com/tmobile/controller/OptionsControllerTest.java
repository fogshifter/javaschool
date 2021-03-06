package com.tmobile.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tmobile.config.AppConfig;
import com.tmobile.dto.OptionDTO;
import com.tmobile.service.OptionsService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.security.web.FilterChainProxy;
import org.springframework.test.context.junit.jupiter.web.SpringJUnitWebConfig;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.ArrayList;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringJUnitWebConfig(value = AppConfig.class)
public class OptionsControllerTest {

    private static final Integer OPTION_ID = 1;

    @Mock
    private OptionsService service;

    @InjectMocks
    private OptionsController controller;

    @Autowired
    private FilterChainProxy springSecurityFilterChain;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);

        mockMvc = MockMvcBuilders
                .standaloneSetup(controller)
                .alwaysDo(print())
                .apply(springSecurity(springSecurityFilterChain))
                .build();
        //when(contractService.getContract(CONTRACT_ID)).thenReturn(new ContractInfoDTO());
    }

    @Test
    @WithMockUser(roles = "MANAGER")
    public void getAll() throws Exception {
        String url = "/options";

        this.mockMvc.perform(get(url)
                .with(csrf())
                .accept(MediaType.APPLICATION_JSON_UTF8)
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());
    }

    @Test
    @WithMockUser(roles = "MANAGER")
    public void remove() throws Exception {
        String url = "/options";

        this.mockMvc.perform(delete(url)
                .with(csrf())
                .accept(MediaType.APPLICATION_JSON_UTF8)
                .content(new ObjectMapper().writeValueAsString(new ArrayList<>()))
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());
    }

    @Test
    @WithMockUser(roles = "MANAGER")
    public void getOption() throws Exception {
        String url = "/options/{optionId}";

        this.mockMvc.perform(get(url, OPTION_ID)
                .with(csrf())
                .accept(MediaType.APPLICATION_JSON_UTF8)
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());
    }

    @Test
    @WithMockUser(roles = "MANAGER")
    public void createOption() throws Exception {
        String url = "/options";

        this.mockMvc.perform(post(url)
                .with(csrf())
                .accept(MediaType.APPLICATION_JSON_UTF8)
                .content(new ObjectMapper().writeValueAsString(new OptionDTO()))
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());
    }

    @Test
    @WithMockUser(roles = "MANAGER")
    public void updateOption() throws Exception {
        String url = "/options";

        this.mockMvc.perform(put(url)
                .with(csrf())
                .accept(MediaType.APPLICATION_JSON_UTF8)
                .content(new ObjectMapper().writeValueAsString(new OptionDTO()))
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());
    }

    @Test
    @WithMockUser(roles = "MANAGER")
    public void getCompatibleOptions() throws Exception {
        String url = "/options/compatible";

        this.mockMvc.perform(get(url)
                .param("requiredOptions", OPTION_ID.toString())
                .with(csrf())
                .accept(MediaType.APPLICATION_JSON_UTF8)
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());
    }

    @Test
    @WithMockUser(roles = "MANAGER")
    public void getRequredOptions() throws Exception {
        String url = "/options/required";

        this.mockMvc.perform(get(url)
                .param("optionsIds", OPTION_ID.toString())
                .with(csrf())
                .accept(MediaType.APPLICATION_JSON_UTF8)
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());
    }

    @Test
    @WithMockUser(roles = "MANAGER")
    public void getRequiredOptionsRestrictions() throws Exception {
        String url = "/options/restrictions";

        this.mockMvc.perform(get(url)
                .param("requiredOptions", OPTION_ID.toString())
                .with(csrf())
                .accept(MediaType.APPLICATION_JSON_UTF8)
                .contentType(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(status().isOk());
    }
}
