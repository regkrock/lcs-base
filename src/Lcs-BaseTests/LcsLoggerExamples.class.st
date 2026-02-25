Class {
	#name : 'LcsLoggerExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-BaseTests-Examples',
	#package : 'Lcs-BaseTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsLoggerExamples >> loggerSwitchedToStreamLogging [
	<gtExample>
	| aLogger |
	aLogger := self newLogger.
	aLogger streamLoggingOn.
	self assert: (aLogger stream class = WriteStream).
	^ aLogger
]

{ #category : 'examples' }
LcsLoggerExamples >> loggerWhereLoggingTurnedOff [
	<gtExample>
	| aLogger |
	aLogger := self newLogger.
	self assert: (aLogger stream class = NullStream).
	aLogger streamLoggingOn.
	self assert: (aLogger stream class = WriteStream).
	aLogger loggingOff.
	self assert: (aLogger stream class = NullStream).
	^ aLogger
]

{ #category : 'examples' }
LcsLoggerExamples >> loggerWithTranscriptLoggingReseted [
	<gtExample>
	| aLogger |
	aLogger := self newLogger.
	aLogger transcriptLoggingOn.
	self assert: (aLogger stream isStream not).
	self assert: aLogger tabLevel equals: 0.
	aLogger indent.
	aLogger indent.
	self assert: aLogger tabLevel equals: 2.
	aLogger reset.
	self assert: aLogger tabLevel equals: 0.
	^ aLogger
]

{ #category : 'examples' }
LcsLoggerExamples >> loggerWithTranscriptLoggingTurnedOn [
	<gtExample>
	| aLogger |
	aLogger := self newLogger.
	aLogger transcriptLoggingOn.
	self assert: (aLogger stream = Transcript).
	^ aLogger
]

{ #category : 'examples' }
LcsLoggerExamples >> newLogger [
	<gtExample>
	| aLogger |
	aLogger := LcsLogger new.
	self assert: (aLogger stream class = NullStream).
	self assert: aLogger tabLevel equals: 0.
	^ aLogger
]

{ #category : 'examples' }
LcsLoggerExamples >> resettedLogger [
	<gtExample>
	| aLogger |
	aLogger := self newLogger.
	self assert: (aLogger stream class = NullStream).
	self assert: aLogger tabLevel equals: 0.
	aLogger indent.
	aLogger indent.
	self assert: aLogger tabLevel equals: 2.
	aLogger reset.
	self assert: aLogger tabLevel equals: 0.
	^ aLogger
]
