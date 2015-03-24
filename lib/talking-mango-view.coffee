module.exports =
class TalkingMangoView
  constructor: (serializeState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('talking-mango',  'overlay', 'from-top')

    # Create message element
    message = document.createElement('div')
    message.textContent = "The TalkingMango package is Alive! It's ALIVE!"
    message.classList.add('message')
    @element.appendChild(message)

    # Register command that toggles this view
    atom.commands.add 'atom-workspace', 'talking-mango:toggle': => @toggle()
    atom.commands.add 'atom-workspace', 'talking-mango:start': => @start()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  start: ->
    msg = new SpeechSynthesisUtterance()
    msg.text = "Hello World"
    window.speechSynthesis.speak(msg)

    # might have to move it to the constructor
    recognition = new webkitSpeechRecognition()
    recognition.continuous = false
    recognition.interimResults = true

    recognition.onstart = () ->
      console.log "started"

    recognition.onend = () ->
      console.log "end"

    recognition.onresult = (event) ->
      i = event.resultIndex
      while i < event.results.length
          if event.results[i].isFinal
            console.log event.results[i][0].transcript
          i++

    recognition.start()

  # Toggle the visibility of this view
  toggle: ->
    console.log 'TalkingMangoView was toggled!'

    if @element.parentElement?
      @element.remove()
    else
      atom.workspaceView.append(@element)
