﻿/**
 * Copyright (c) 2009-2010, The HSL Contributors. Most notable contributors, in order of appearance: Pimm Hogeling, Edo Rivai,
 * Owen Durni.
 *
 * This file is part of HSL. HSL, pronounced "hustle", stands for haXe Signaling Library.
 *
 * HSL is free software. Redistribution and use in source and binary forms, with or without modification, are permitted
 * provided that the following conditions are met:
 *
 *   * Redistributions of source code must retain the above copyright notice, this list of conditions and the following
 *     disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following
 *     disclaimer in the documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE HSL CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE HSL
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * End of conditions.
 * 
 * The license of HSL might change in the near future, most likely to match the license of the haXe core libraries.
 */
package org.hsl.avm2.translation.mouse;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import org.hsl.haxe.translation.Translation;
import org.hsl.haxe.translation.Translator;
import org.hsl.haxe.translation.NativeEvent;

/**
 * A translator that translates mouse events to local mouse locations. The local mouse locations are the locations of the mouse
 * at the moment the mouse events were dispatched, relative to the object that dispatched them.
 */
class MouseLocationTranslator implements Translator<LocalMouseLocation> {
	/**
	 * Creates a new mouse location translator.
	 */
	public function new():Void {
	}
	public function translate(nativeEvent:NativeEvent):Translation<LocalMouseLocation> {
		var mouseEvent:MouseEvent;
		try {
			mouseEvent = cast(nativeEvent, MouseEvent);
		} catch (error:Dynamic) {
			throw "The nativeEvent argument must be a MouseEvent.";
		}
		// The scope argument of the local mouse location constructor is a display object. The target property of the mouseEvent
		// variable is dynamic, but since mouse events are dispatched by display objects only in the common cases we'll assume that
		// the target property is a display object, too. However, AS3 compilers don't like this. We have to cast it explicitly for
		// them.
		#if as3
		return new Translation<LocalMouseLocation>(new LocalMouseLocation(mouseEvent.localX, mouseEvent.localY, cast(mouseEvent.target, DisplayObject)), mouseEvent.target);
		#else
		return new Translation<LocalMouseLocation>(new LocalMouseLocation(mouseEvent.localX, mouseEvent.localY, mouseEvent.target), mouseEvent.target);
		#end
	}
	#if debug
	private function toString():String {
		return "[Translator]";
	}
	#end
}