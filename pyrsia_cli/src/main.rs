/*
   Copyright 2021 JFrog Ltd

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

pub mod cli;

use cli::handlers::*;
use cli::parser::*;

const SUBCOMMAND_CONFIG_EDIT: &str = "TEST";

#[tokio::main]
async fn main() {
    // parsing command line arguments
    let matches = cli_parser();

    // checking and preparing responses for each command and its arguments if applicable

    match matches.subcommand() {
        Some(("config", config_matches)) => {
            if config_matches.is_present("add") {
                config_add();
            }
            if config_matches.is_present("show") {
                config_show();
            }

            match config_matches.subcommand() {
                Some(("edit", edit_matches)) => {
                    if edit_matches.is_present("all") {
                        config_add();
                    }
                    if edit_matches.is_present("port") {
                        config_port();
                    }
                    if edit_matches.is_present("storage") {
                        config_port();
                    }
                    if edit_matches.is_present("address") {
                        config_port();
                    }
                }
                _ => {}
            }
        }
        Some(("authorize", authorize_matches)) => {
            authorize(authorize_matches.get_one::<String>("peer").unwrap()).await;
        }
        Some((SUBCOMMAND_BUILD, build_matches)) => match build_matches.subcommand() {
            Some((SUBCOMMAND_DOCKER, docker_matches)) => {
                request_docker_build(docker_matches.get_one::<String>("image").unwrap()).await;
            }
            Some((SUBCOMMAND_MAVEN, maven_matches)) => {
                request_maven_build(maven_matches.get_one::<String>("gav").unwrap()).await;
            }
            _ => {}
        },
        Some((SUBCOMMAND_LIST, _config_matches)) => {
            node_list().await;
        }
        Some((SUBCOMMAND_PING, _config_matches)) => {
            node_ping().await;
        }
        Some((SUBCOMMAND_STATUS, _config_matches)) => {
            node_status().await;
        }
        Some((SUBCOMMAND_INSPECT_LOG, build_matches)) => match build_matches.subcommand() {
            Some((SUBCOMMAND_DOCKER, docker_matches)) => {
                inspect_docker_transparency_log(docker_matches.get_one::<String>("image").unwrap())
                    .await;
            }
            Some((SUBCOMMAND_MAVEN, maven_matches)) => {
                inspect_maven_transparency_log(maven_matches.get_one::<String>("gav").unwrap())
                    .await;
            }
            _ => {}
        },
        _ => {} //this should be handled by clap arg_required_else_help
    }
}
