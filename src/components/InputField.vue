<template>
  <div class="input-group">
    <label @focus="focusEvent" :for="label"
           :class="[{focused: isFocused}, 'form-label']"
           :style="{color: color}">
      {{ placeholder }}
    </label>
    <div class="input-field">
      <input @focus="focusEvent"
             @blur="blurEvent"
             ref="inputField"
             :id="label"
             :name="label"
             :class="[{filled: isFilled}, 'form-input']"
             type="text"
             :autocomplete="label"
             :style="{color: color}">
    </div>
  </div>
</template>
<script>
  // TODO: create a way to send input up and out of component
  // TODO: Emit onFocus/onBlur event(maybe) if .native don't work
  export default {
    name: 'InputField',
    props: ['placeholder', 'label', 'color'],
    data () {
      return {
        isFocused: false,
        isFilled: false
      }
    },
    methods: {
      focusEvent: function () {
        this.isFocused = true
        console.log('focus-event')
      },
      blurEvent: function () {
        if (this.$refs.inputField.value === '') {
          this.isFilled = false
          this.isFocused = false
          console.log('!filled')
        } else {
          this.isFilled = false
          console.log('filled')
        }
        console.log('blur-event')
      }
    }
  }
</script>
<style lang="scss" scoped>
  .input-group {
    position: relative;
    width: 100%;

    label {
      font-size: 5vw;
      position: absolute;
      left: 0;
      top: 10px;
      color: #999;
      background-color: transparent;
      transition: font-size 150ms ease-out, -webkit-transform 150ms ease-out;
      transition: transform 150ms ease-out, font-size 150ms ease-out;
      transition: transform 150ms ease-out, font-size 150ms ease-out, -webkit-transform 150ms ease-out;
      &.focused {
        -webkit-transform: translateY(-125%);
        transform: translateY(-125%);
        font-size: 3vw;
      }
    }
    .input-field {
      input {
        font-size: 5vw;
        position: relative;
        padding: 10px 0;
        width: 100%;
        outline: 0;
        border: 0;
        background-color: transparent;
        box-shadow: 0 1px 0 0 #e5e5e5;
        transition: box-shadow 150ms ease-out;
        &.filled {
          box-shadow: 0 1px 0 0 #1e3e1f;
        }
      }
    }
  }
</style>
                                                                                                                         
