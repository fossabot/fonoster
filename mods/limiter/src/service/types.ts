/*
 * Copyright (C) 2022 by Fonoster Inc (https://fonoster.com)
 * http://github.com/fonoster/fonoster
 *
 * This file is part of Fonoster
 *
 * Licensed under the MIT License (the "License");
 * you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *    https://opensource.org/licenses/MIT
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import {UserStatus} from "@fonoster/users/dist/service/types";

export enum TimeUnit {
  DAY = "day",
  MONTH = "month",
  EVER = "ever"
}

export interface Limit {
  path: string;
  resource: string;
  limit: number;
  timeUnit: TimeUnit;
  allowedForStatus: UserStatus;
}

export interface Limiter {
  name: string;
  limits: Limit[];
}