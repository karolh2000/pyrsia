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

use clap::{arg, command, crate_version, AppSettings, ArgMatches, Command};
use const_format::formatcp;

// command names
pub const SUBCOMMAND_AUTHORIZE: &str = "authorize";
pub const SUBCOMMAND_BUILD: &str = "build";
pub const SUBCOMMAND_DOCKER: &str = "docker";
pub const SUBCOMMAND_MAVEN: &str = "maven";
pub const SUBCOMMAND_CONFIG: &str = "config";
pub const SUBCOMMAND_CONFIG_ADD: &str = "add";
pub const SUBCOMMAND_CONFIG_EDIT: &str = "edit";
pub const SUBCOMMAND_INSPECT_LOG: &str = "inspect-log";
pub const SUBCOMMAND_LIST: &str = "list";
pub const SUBCOMMAND_PING: &str = "ping";
pub const SUBCOMMAND_STATUS: &str = "status";

pub fn cli_parser() -> ArgMatches {
    let version_string: &str = formatcp!("{} ({})", crate_version!(), env!("VERGEN_GIT_SHA"));
    command!()
        .arg_required_else_help(true)
        .global_setting(AppSettings::DeriveDisplayOrder)
        .propagate_version(false)
        // Config subcommand
        .subcommands(vec![
            Command::new(SUBCOMMAND_AUTHORIZE)
                .about("Add an authorized node")
                .arg_required_else_help(true)
                .args(&[
                    arg!(-p --peer <PEER_ID>      "Peer ID of the node to authorize"),
                ]),
            Command::new(SUBCOMMAND_BUILD)
                .short_flag('b')
                .about("Request a new build")
                .setting(AppSettings::SubcommandRequiredElseHelp)
                .subcommands(vec![
                    Command::new(SUBCOMMAND_DOCKER)
                        .about("Request a new build for a Docker image")
                        .arg_required_else_help(true)
                        .args(&[
                            arg!(--image <IMAGE> "The docker image to download (e.g. alpine:3.15.3 or alpine@sha256:1e014f84205d569a5cc3be4e108ca614055f7e21d11928946113ab3f36054801"),
                        ]),
                    Command::new(SUBCOMMAND_MAVEN)
                        .about("Request a new build for a maven artifact")
                        .arg_required_else_help(true)
                        .args(&[
                            arg!(--gav <GAV> "The maven GAV (e.g. org.myorg:my-artifact:1.1.0)"),
                        ]),
                ]),
            Command::new(SUBCOMMAND_CONFIG)
                .short_flag('c')
                .about("Configure Pyrsia")
                .arg_required_else_help(true)
                .args(&[
                    arg!(-a --add      "Adds a node configuration"),
                    arg!(-r --remove   "Removes the stored node configuration").visible_alias("rm"),
                    arg!(-s --show     "Shows the stored node configuration")
                ]).subcommands(vec![
                Command::new(SUBCOMMAND_CONFIG_EDIT)
                    .about("Edit Pyrsia configuration")
                    .arg_required_else_help(true)
                    .args(&[
                        arg!(-l --all                       "Updates all nodes params"),
                        arg!(-p --port <PORT_NUMBER>        "Updates a node port").required(false),
                        arg!(-d --storage <STORAGE_SPACE>   "Updates a node storage allocation").required(false),
                        arg!(-a --address <ADDRESS>         "Updates a node host address").required(false)
                    ]),
            ]),
            Command::new(SUBCOMMAND_INSPECT_LOG)
                .about("Show transparency logs")
                .setting(AppSettings::SubcommandRequiredElseHelp)
                .subcommands(vec![
                    Command::new(SUBCOMMAND_DOCKER)
                        .about("Show transparency logs for a Docker image")
                        .arg_required_else_help(true)
                        .args(&[
                            arg!(--image <IMAGE> "The docker image (e.g. alpine:3.15.3 or alpine@sha256:1e014f84205d569a5cc3be4e108ca614055f7e21d11928946113ab3f36054801"),
                        ]),
                    Command::new(SUBCOMMAND_MAVEN)
                        .about("Show transparency logs for a maven artifact")
                        .arg_required_else_help(true)
                        .args(&[
                            arg!(--gav <GAV> "The maven GAV (e.g. org.myorg:my-artifact:1.1.0)"),
                        ]),
                ]),
            Command::new(SUBCOMMAND_LIST)
                .short_flag('l')
                .about("Show a list of connected peers"),
            Command::new(SUBCOMMAND_PING).about("Pings configured pyrsia node"),
            Command::new(SUBCOMMAND_STATUS)
                .short_flag('s')
                .about("Show information about the Pyrsia node"),
        ])
        .version(version_string)
        .get_matches()
}
