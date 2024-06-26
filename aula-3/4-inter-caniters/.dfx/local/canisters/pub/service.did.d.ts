import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface Counter { 'topic' : string, 'value' : bigint }
export interface Subscriber {
  'topic' : string,
  'callback' : [Principal, string],
}
export interface _SERVICE {
  'publish' : ActorMethod<[Counter], undefined>,
  'subscribe' : ActorMethod<[Subscriber], undefined>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
